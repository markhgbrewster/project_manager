# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    message { 'MyText' }
    user { nil }
    commentable { nil }
  end
end
