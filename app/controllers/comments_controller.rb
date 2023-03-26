# frozen_string_literal: true

class CommentsController < ApplicationController
  include HistoryLoggable

  before_action :authenticate_user!, :set_project

  def create
    @comment = current_user.comments.new(commentable: @project)

    respond_to do |format|
      if @comment.update(comment_params) && logged_history(@project)
        format.html do
          redirect_to project_url(@project), notice: notice_message
        end
      else
        format.html { head :unprocessable_entity }
      end
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def notice_message
    'Comment was successfully added'
  end

  def message_for_history
    "#{current_user.full_name} commented: '#{@comment.message}'"
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end
