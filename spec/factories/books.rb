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
FactoryBot.define do
  factory :book do
    title { "Sample Book" }
    author { "Author Name" }
    publication_year { 2022 }
    isbn { "048665088X" }
  end
end
