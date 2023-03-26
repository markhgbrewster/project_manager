# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/', type: :request do
  let(:user) { FactoryBot.create(:user) }

  context 'GET #index' do
    context 'when a user is signed in' do
      before { sign_in(user, scope: :user) }

      it 'renders a successful response' do
        get root_path
        expect(response).to be_successful
      end
    end

    context 'when a user is not signed in' do
      it 'renders a successful response' do
        get root_path
        expect(response).to be_successful
      end
    end
  end
end