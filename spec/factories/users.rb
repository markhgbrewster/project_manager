# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3, '0')}@sample.com" }
    password { '123456' }
    first_name { 'Leslie' }
    last_name { 'Smith' }
  end
end
