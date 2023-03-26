# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { 'MyString' }
    description { 'MyText' }
    state { 'MyString' }
    user { nil }
  end
end
