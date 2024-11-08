require 'rails_helper'

RSpec.describe ReviewsController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:book) { create(:book) }
  let(:review) { create(:review, book: book, user: user, created_at: Time.current) }

  before { sign_in user }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:review_params) { attributes_for(:review) }

      it 'creates a new review and redirects to book show page' do
        expect {
          post book_reviews_path(book), params: { review: review_params }
        }.to change(book.reviews, :count).by(1)
        expect(response).to redirect_to(book_path(book))
        expect(flash[:notice]).to eq('Review added successfully.')
      end
    end

    context 'with invalid attributes' do
      let(:review_params) { attributes_for(:review, content: '') }

      it 'does not create a review and re-renders the book show template' do
        expect {
          post book_reviews_path(book), params: { review: review_params }
        }.not_to change(book.reviews, :count)
        expect(response).to render_template('books/show')
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'GET #edit' do
    context 'when the user owns the review' do
      it 'renders the edit template' do
        get edit_book_review_path(book, review)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    context 'when the user does not own the review' do
      before { sign_in other_user }

      it 'redirects to book show page with an alert' do
        get edit_book_review_path(book, review)
        expect(response).to redirect_to(book_path(book))
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end
  end

  describe 'PATCH #update' do
    context 'when the user owns the review' do
      let(:new_content) { 'Updated content' }

      it 'updates the review and redirects to book show page' do
        patch book_review_path(book, review), params: { review: { content: new_content } }
        review.reload
        expect(review.content).to eq(new_content)
        expect(response).to redirect_to(book_path(book))
        expect(flash[:notice]).to eq('Review updated successfully!')
      end
    end

    context 'when the user does not own the review' do
      before { sign_in other_user }

      it 'does not update the review and redirects to book show page with an alert' do
        patch book_review_path(book, review), params: { review: { content: 'Updated content' } }
        expect(review.reload.content).not_to eq('Updated content')
        expect(response).to redirect_to(book_path(book))
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when the user owns the review' do
      before do
        sign_in user
        review.update(user: user) # Ensure the review is owned by the signed-in user
      end

      it 'deletes the review and redirects to book show page' do
        expect {
          delete book_review_path(book, review)
        }.to change(book.reviews, :count).by(-1)
        expect(response).to redirect_to(book_path(book))
        expect(flash[:notice]).to eq('Review deleted successfully!')
      end
    end

    context 'when the user does not own the review' do
      before do
        sign_in other_user
        review.update(user: user) # Ensure the review is owned by a different user
      end

      it 'does not delete the review and redirects to book show page with an alert' do
        expect {
          delete book_review_path(book, review)
        }.not_to change(book.reviews, :count)
        expect(response).to redirect_to(book_path(book))
        expect(flash[:alert]).to eq('You are not authorized to perform this action.')
      end
    end
  end
end
