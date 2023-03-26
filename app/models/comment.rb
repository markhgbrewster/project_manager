# frozen_string_literal: true

class Comment < ApplicationRecord
  # I prefer to ues ".name" rather than a hard coded string for class names
  # As it will fail hard if there are any typos or the class name get changed
  ALLOWED_COMMENTABLE_TYPES = [Project.name].freeze

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :commentable, :user, :message, presence: true
  validates :commentable_type, inclusion: { in: ALLOWED_COMMENTABLE_TYPES }
end
