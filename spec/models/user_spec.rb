# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should have_many(:reviews).dependent(:destroy) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value('test@example.com').for(:email) }
  it { should_not allow_value('invalid_email').for(:email) }

  it 'validates password presence' do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'validates password length' do
    user = build(:user, password: 'short')
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  describe 'Devise modules' do
    it 'responds to database_authenticatable' do
      expect(User).to respond_to(:find_for_database_authentication)
    end

    it 'responds to registerable' do
      expect(User).to respond_to(:new_with_session)
    end

    it 'responds to recoverable' do
      expect(User).to respond_to(:send_reset_password_instructions)
    end

    it 'responds to rememberable' do
      user = build(:user)
      expect(user).to respond_to(:remember_me)
    end

    it 'responds to validatable' do
      user = build(:user, email: 'invalid_email')
      user.validate
      expect(user.errors[:email]).to include('is invalid')
    end
  end

  describe 'callbacks' do
    it 'destroys associated reviews when the user is deleted' do
      user = create(:user)
      review = create(:review, user: user)
      expect { user.destroy }.to change { Review.count }.by(-1)
    end
  end
end
