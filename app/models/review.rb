# == Schema Information
#
# Table name: reviews
#
#  id         :bigint           not null, primary key
#  content    :text
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_reviews_on_book_id  (book_id)
#  index_reviews_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book, touch: true

  validates :user, presence: true
  validates :content, presence: true
  validates :rating, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :book_id, message: "You have already reviewed this book" }
end
