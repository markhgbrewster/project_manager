# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { FactoryBot.create(:user) }

  let(:valid_params) { { message: 'This is a great Project' } }
  let(:invalid_params) { { message: nil } }

  let(:project) do
    FactoryBot.create(
      :project,
      user: user,
      title: 'TEST',
      description: 'TEST',
      state: 'backlog'
    )
  end

  describe 'POST /create' do
    context 'when the user is signed in' do
      before { sign_in(user, scope: :user) }

      context 'with valid parameters' do
        it 'creates the comment' do
          post comments_path(project), params: { comment: valid_params }
          project.reload
          expect(project.comments.last).to have_attributes(valid_params)
        end

        it 'creates a history record' do
          expect {
            post comments_path(project), params: { comment: valid_params }
          }.to change(ProjectHistory, :count).by(1)
        end

        it 'redirects to the project' do
          post comments_path(project), params: { comment: valid_params }
          project.reload
          expect(response).to redirect_to(project_path(project))
        end
      end

      context 'with invalid parameters' do
        it 'renders a response with 422 status' do
          post comments_path(project), params: { comment: invalid_params }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to the sign in page' do
        post comments_path(project), params: { comment: valid_params }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
