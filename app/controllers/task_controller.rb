require 'aws-sdk-s3'
require "google/cloud/vision"
class TaskController < ApplicationController
  def active_tasks
    agent = current_agent
    @current_agent_tasks = []
    agent.tasks_blobs.each do |blob|
      if Analysis.where(blob_id: blob, correct_label: nil)
        @current_agent_tasks << agent.tasks.find_by(blob_id: blob)
      end
    end
  end
  def label_correct
    agent = current_agent
    image = agent.tasks.find(params[:id])
    Analysis.find_by(blob_id: image.blob).update(correct_label: true)
    redirect_to root_path
  end

  def label_incorrect
    agent = current_agent
    image = agent.tasks.find(params[:id])
    Analysis.find_by(blob_id: image.blob).update(correct_label: false)
    redirect_to root_path
  end

  def finished_tasks
    @current_agent_tasks = current_agent
  end
end