require 'rails_helper'

RSpec.describe BooksController, type: :request do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  describe 'GET #index' do
    it 'renders the index template' do
      get books_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    context 'when the book exists' do
      it 'renders the show template' do
        get book_path(book)
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
      end
    end

    context 'when the book does not exist' do
      it 'redirects to index with a flash alert' do
        get book_path(id: 'nonexistent')
        expect(response).to redirect_to(books_path)
        expect(flash[:alert]).to eq('Book not found.')
      end
    end
  end

  describe 'GET #new' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'renders the new template' do
        get new_book_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get new_book_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid attributes' do
        let(:book_params) { attributes_for(:book) }

        it 'creates a new book and redirects to index' do
          expect {
            post books_path, params: { book: book_params }
          }.to change(Book, :count).by(1)
          expect(response).to redirect_to(books_path)
          expect(flash[:notice]).to eq('Book successfully added!')
        end
      end

      context 'with invalid attributes' do
        let(:book_params) { attributes_for(:book, title: '') }

        it 'does not create a book and re-renders the new template' do
          expect {
            post books_path, params: { book: book_params }
          }.not_to change(Book, :count)
          expect(response).to render_template(:new)
          expect(flash[:alert]).to be_present
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        post books_path, params: { book: attributes_for(:book) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
