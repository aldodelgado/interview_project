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
require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { described_class.new(title: 'Sample Book', author: 'Author Name', isbn: '123456789X', publication_year: 2023) }

  describe 'associations' do
    it { is_expected.to have_many(:reviews).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:isbn) }
    it { is_expected.to validate_uniqueness_of(:isbn).with_message('number already exists in the library') }

    describe '#isbn_must_be_valid' do
      it 'is valid with a correct ISBN-10' do
        book.isbn = '123456789X'
        expect(book).to be_valid
      end

      it 'is valid with a correct ISBN-13' do
        book.isbn = '9781234567897'
        expect(book).to be_valid
      end

      it 'is invalid with an incorrect ISBN' do
        book.isbn = '1234567890'
        book.validate
        expect(book.errors[:isbn]).to include('must be a valid ISBN-10 or ISBN-13')
      end
    end
  end

  describe 'callbacks' do
    describe '#strip_isbn_hyphens' do
      it 'removes hyphens from the ISBN before validation' do
        book.isbn = '978-1-234-56789-7'
        book.valid?
        expect(book.isbn).to eq('9781234567897')
      end
    end

    describe '#ensure_cover_image' do
      it 'creates a cover image file if it does not exist' do
        # Define the expected path
        cover_image_path = Rails.root.join('public', 'covers', "isbn_#{book.isbn}-M.jpg")

        # Clean up any existing test file to avoid false positives
        FileUtils.rm(cover_image_path) if File.exist?(cover_image_path)

        # Run the save to trigger the callback
        book.save!

        # Check if the file has been created as expected
        expect(File.exist?(cover_image_path)).to be true

        # Clean up the test file
        FileUtils.rm(cover_image_path)
      end
    end
  end

  describe 'scopes' do
    let!(:book1) { create(:book, title: 'Alpha', author: 'Author One', isbn: '123456789X', publication_year: 2022) }
    let!(:book2) { create(:book, title: 'Beta', author: 'Author Two', isbn: '9781234567897', publication_year: 2023) }

    describe '.search' do
      it 'returns books that match the title or author' do
        expect(Book.search('Alpha')).to include(book1)
        expect(Book.search('Author Two')).to include(book2)
      end
    end

    describe '.sorted_by' do
      it 'sorts by title' do
        expect(Book.sorted_by('title')).to eq([book1, book2])
      end

      it 'sorts by author' do
        expect(Book.sorted_by('author')).to eq([book1, book2])
      end

      it 'sorts by publication_year in descending order' do
        expect(Book.sorted_by('publication_year')).to eq([book2, book1])
      end
    end
  end

  describe 'instance methods' do
    describe '#average_rating' do
      let!(:review1) { create(:review, book: book, rating: 4) }
      let!(:review2) { create(:review, book: book, rating: 5) }

      it 'calculates the average rating of reviews' do
        expect(book.average_rating).to eq(4.5)
      end
    end

    describe '#cover_image_url' do
      it 'returns the local cover image path if it exists' do
        allow(File).to receive(:exist?).and_return(true)
        expect(book.cover_image_url).to match(%r{/covers/isbn_#{book.isbn}-M.jpg})
      end

      it 'downloads the cover image if it does not exist locally' do
        allow(File).to receive(:exist?).and_return(false)
        allow(book).to receive(:download_cover_image)
        book.cover_image_url
        expect(book).to have_received(:download_cover_image)
      end
    end
  end
end
