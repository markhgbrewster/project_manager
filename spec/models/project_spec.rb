require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:project_histories) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:state) }
  end
end
