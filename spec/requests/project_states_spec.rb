# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/projects/:id/state', type: :request do
  let(:user) { FactoryBot.create(:user) }

  let(:valid_params) { { state: 'on_hold' } }
  let(:invalid_params) { { state: 'some_rubbish' } }

  let(:project) do
    FactoryBot.create(
      :project,
      user: user,
      title: 'TEST',
      description: 'TEST',
      state: 'backlog'
    )
  end

  describe 'PATCH /update' do
    context 'when the user is signed in' do
      before { sign_in(user, scope: :user) }

      context 'with valid parameters' do
        it 'updates the requested project state' do
          patch project_state_project_path(project), params: { project: valid_params }
          project.reload
          expect(project).to have_attributes(valid_params)
        end

        it 'creates a history record' do
          expect {
            patch project_state_project_path(project), params: { project: valid_params }
          }.to change(ProjectHistory, :count).by(1)
        end

        it 'redirects to the project' do
          patch project_state_project_path(project), params: { project: valid_params }
          project.reload
          expect(response).to redirect_to(project_path(project))
        end
      end

      context 'with invalid parameters' do
        it 'renders a response with 422 status' do
          patch project_state_project_path(project), params: { project: invalid_params }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to the sign in page' do
        patch project_state_project_path(project), params: { project: valid_params }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
