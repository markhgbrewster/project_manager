class ProjectStatesController < ApplicationController
  include HistoryLoggable

  before_action :authenticate_user!, :set_project

  def update
    respond_to do |format|
      if @project.update(project_params) && logged_history(@project)
        format.html do
          redirect_to project_url(@project), notice: success_notice
        end
      else
        format.html { head :unprocessable_entity }
      end
    end
  end

  private

  def success_notice
    "Project's status successfully changed to #{new_state}"
  end

  def message_for_history
    "#{current_user.full_name} changed the status to #{new_state}"
  end

  def new_state
    @new_state ||= @project.state.humanize.capitalize
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:state)
  end
end
