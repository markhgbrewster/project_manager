# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectHistory, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:project) }
  end
end
