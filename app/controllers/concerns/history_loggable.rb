# frozen_string_literal: true

module HistoryLoggable
  extend ActiveSupport::Concern

  private

  def logged_history(project)
    project.project_histories.create(user: current_user, description: message_for_history)
  end
end
