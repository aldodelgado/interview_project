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
class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :isbn, presence: true, uniqueness: true
end
