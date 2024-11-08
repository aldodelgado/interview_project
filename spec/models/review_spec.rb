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
require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  subject(:review) { described_class.create!(content: 'Great book!', rating: 5, user: user, book: book) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:book).touch(true) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }

    it 'validates uniqueness of user scoped to book' do
      described_class.create!(content: 'Great book!', rating: 4, user: user, book: book)
      duplicate_review = described_class.new(content: 'Another review', rating: 3, user: user, book: book)
      expect(duplicate_review).not_to be_valid
      expect(duplicate_review.errors[:user_id]).to include('You have already reviewed this book')
    end
  end

  describe 'database constraints' do
    it 'has a foreign key constraint on book_id' do
      expect { review.update_column(:book_id, 999) }.to raise_error(ActiveRecord::InvalidForeignKey)
    end

    it 'has a foreign key constraint on user_id' do
      expect { review.update_column(:user_id, 999) }.to raise_error(ActiveRecord::InvalidForeignKey)
    end
  end

  describe 'valid review creation' do
    it 'is valid with valid attributes' do
      expect(review).to be_valid
    end

    it 'is invalid with a rating below 1' do
      review.rating = 0
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include('is not included in the list')
    end

    it 'is invalid with a rating above 5' do
      review.rating = 6
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include('is not included in the list')
    end
  end
end
