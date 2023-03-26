# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/projects', type: :request do
  let(:user) { FactoryBot.create(:user) }

  let(:valid_params) { { title: 'TEST', description: 'TEST' } }
  let(:invalid_params) { { title: nil, description: nil } }

  let(:project) do
    FactoryBot.create(
      :project,
      user: user,
      title: 'TEST',
      description: 'TEST',
      state: 'backlog'
    )
  end

  context 'GET #index' do
    context 'when a user is signed in' do
      before { sign_in(user, scope: :user) }

      it 'renders a successful response' do
        get projects_url
        expect(response).to be_successful
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to the sign in page' do
        get projects_url
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  context 'GET #new' do
    context 'when a user is signed in' do
      before { sign_in(user, scope: :user) }

      it 'renders a successful response' do
        get new_project_url
        expect(response).to be_successful
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to the sign in page' do
        get new_project_url
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  context 'GET #edit' do
    context 'when a user is signed in' do
      before { sign_in(user, scope: :user) }

      it 'renders a successful response' do
        get edit_project_url(project)
        expect(response).to be_successful
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to the sign in page' do
        get edit_project_url(project)
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  context 'GET #show' do
    context 'when a user is signed in' do
      before { sign_in(user, scope: :user) }

      it 'renders a successful response' do
        get project_url(project)
        expect(response).to be_successful
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to the sign in page' do
        get project_url(project)
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'POST /create' do
    context 'when the user is signed in' do
      before { sign_in(user, scope: :user) }

      context 'when valid parameters are sent' do
        let(:expected_attributes) { { title: 'TEST', description: 'TEST', state: 'backlog' } }

        it 'creates a new Project' do
          expect {
            post projects_url, params: { project: valid_params }
          }.to change(Project, :count).by(1)
        end

        it 'redirects to the created project' do
          post projects_url, params: { project: valid_params }
          expect(response).to redirect_to(project_url(Project.last))
        end

        it 'show have the correct attributes' do
          post projects_url, params: { project: valid_params }
          expect(Project.last).to have_attributes(expected_attributes)
        end
      end

      context 'when the parameters are invalid parameters' do
        it 'does not create a new Project' do
          expect {
            post projects_url, params: { project: invalid_params }
          }.to change(Project, :count).by(0)
        end

        it 'renders a response with 422 status' do
          post projects_url, params: { project: invalid_params }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to the sign in page' do
        post projects_url, params: { project: valid_params }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'PATCH /update' do
    let(:new_attributes) { { title: 'Hello', description: 'HELLO' } }

    context 'when the user is signed in' do
      before { sign_in(user, scope: :user) }

      context 'with valid parameters' do
        it 'updates the requested project' do
          patch project_url(project), params: { project: new_attributes }
          project.reload
          expect(project).to have_attributes(new_attributes)
        end

        it 'redirects to the project' do
          patch project_url(project), params: { project: new_attributes }
          project.reload
          expect(response).to redirect_to(project_url(project))
        end
      end

      context 'with invalid parameters' do
        it 'renders a response with 422 status' do
          patch project_url(project), params: { project: invalid_params }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to the sign in page' do
        patch project_url(project), params: { project: new_attributes }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when the user is signed in' do
      before { sign_in(user, scope: :user) }

      it 'destroys the requested project' do
        delete project_url(project), params: {}

        expect(Project.exists?(project.id)).to be_falsey
      end

      it 'redirects to the projects list' do
        delete project_url(project)
        expect(response).to redirect_to(projects_url)
      end
    end

    context 'when a user is not signed in' do
      it 'redirects to the sign in page' do
        delete project_url(project), params: {}
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
end
