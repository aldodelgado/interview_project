# == Schema Information
#
# Table name: books
#
#  id               :bigint           not null, primary key
#  author           :string
#  isbn             :string
#  publication_year :integer
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_books_on_author  (author)
#  index_books_on_isbn    (isbn) UNIQUE
#  index_books_on_title   (title)
#
require 'open-uri'

class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy

  before_validation :strip_isbn_hyphens
  after_save :ensure_cover_image

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: { message: "number already exists in the library" }
  validate :isbn_must_be_valid

  scope :search, ->(query) {
    where("title ILIKE :query OR author ILIKE :query", query: "%#{query}%") if query.present?
  }

  scope :sorted_by, ->(sort_option) {
    case sort_option
    when 'title'
      order(:title)
    when 'author'
      order(:author)
    when 'publication_year'
      order(publication_year: :desc)
    when 'rating'
      left_joins(:reviews).group(:id).order('AVG(reviews.rating) DESC')
    else
      order(:title)
    end
  }

  def average_rating
    reviews.average(:rating)&.round(2)
  end

  def cover_image_url(size = 'M')
    local_path = Rails.root.join('public', 'covers', "isbn_#{isbn}-#{size}.jpg")

    if File.exist?(local_path)
      "/covers/isbn_#{isbn}-#{size}.jpg"
    else
      download_cover_image(size, local_path)
    end
  end

  private

  def strip_isbn_hyphens
    self.isbn = isbn&.delete('-')
  end

  def ensure_cover_image
    local_path = Rails.root.join('public', 'covers', "isbn_#{isbn}-M.jpg")
    download_cover_image('M', local_path) unless File.exist?(local_path)
  end

  def download_cover_image(size, local_path)
    url = "https://covers.openlibrary.org/b/isbn/#{isbn}-#{size}.jpg"
    begin
      OpenURI.open_uri(url) do |image|
        FileUtils.mkdir_p(File.dirname(local_path))
        File.write(local_path, image.read, mode: 'wb')
      end
      "/covers/isbn_#{isbn}-#{size}.jpg"
    rescue => e
      Rails.logger.error("Failed to download image: #{e.message}")
      url
    end
  end

  def isbn_must_be_valid
    return if isbn.nil?

    unless valid_isbn10?(isbn) || valid_isbn13?(isbn)
      errors.add(:isbn, 'must be a valid ISBN-10 or ISBN-13')
    end
  end

  def valid_isbn10?(isbn)
    return false unless isbn&.size == 10

    total = 0
    isbn.chars.each_with_index do |char, index|
      if char == 'X' && index == 9
        total += 10 * (index + 1)
      elsif char.match?(/\D/)
        return false
      else
        total += char.to_i * (index + 1)
      end
    end

    total % 11 == 0
  end

  def valid_isbn13?(isbn)
    return false unless isbn&.size == 13 && isbn.match?(/\A\d+\z/)

    total = isbn.chars.each_with_index.sum do |char, index|
      multiplier = index.even? ? 1 : 3
      char.to_i * multiplier
    end

    total % 10 == 0
  end
end
