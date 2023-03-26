class ProjectHistory < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :project, :description, presence: true
end
