class ProjectStatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def update
    respond_to do |format|
      if @project.update(project_params) && logged_history
        format.html do
          redirect_to project_url(@project), notice: success_notice
        end

        format.json { render 'projects/show', status: :ok, location: @project }
      else
        format.html { render 'projects/show', status: :unprocessable_entity }

        format.json do
          render json: @project.errors, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def success_notice
    "Project's status successfully changed to #{new_state}"
  end

  def logged_history
    message = "#{current_user.full_name} changed the status to #{new_state}"

    @project.project_histories.create(user: current_user, description: message)
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
