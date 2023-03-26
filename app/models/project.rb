class Project < ApplicationRecord
  ALLOWED_STATES = %w[backlog in_progress in_review on_hold complete closed].freeze

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :project_histories, dependent: :destroy

  validates :user, :state, :title, :description, presence: true
  validates :state, inclusion: { in: ALLOWED_STATES }
end
