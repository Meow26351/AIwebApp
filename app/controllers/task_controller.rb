require 'aws-sdk-s3'
require "google/cloud/vision"
class TaskController < ApplicationController
  def active_tasks
    @current_agent_tasks = current_agent
  end
  def label_correct
    agent = current_agent
    image = agent.tasks.find(params[:id])
    puts image
    image.update(labeled_correctly: true)
    redirect_to root_path
  end

  def label_incorrect
    agent = current_agent
    image = agent.tasks.find(params[:id])
    puts image
    image.update(labeled_correctly: false)
    redirect_to root_path
  end

  def finished_tasks
    @current_agent_tasks = current_agent
  end
end