class Project < ApplicationRecord
  ALLOWED_STATES = %w[backlog in_progress in_review on_hold complete closed].freeze

  belongs_to :user
  validates  :user, :state, :title, :description, presence: true
  validates :state, inclusion: { in: ALLOWED_STATES }
end
