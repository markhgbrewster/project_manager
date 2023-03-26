# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
  end

  describe 'validations' do
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:commentable) }
  end
end
