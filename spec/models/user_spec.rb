# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:projects) }
    it { should have_many(:comments) }
    it { should have_many(:project_histories) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe '#full_name' do
    let(:user) do
      FactoryBot.create(:user, first_name: 'Bob', last_name: 'Jones')
    end

    it 'returns the full name' do
      expect(user.full_name).to eql('Bob Jones')
    end
  end
end
