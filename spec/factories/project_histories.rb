# frozen_string_literal: true

FactoryBot.define do
  factory :project_history do
    description { 'MyText' }
    user { nil }
    project { nil }
  end
end
