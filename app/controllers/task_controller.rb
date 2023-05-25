require 'aws-sdk-s3'
require "google/cloud/vision"
class TaskController < ApplicationController
  def active_tasks
    agent = current_agent
    images = Analysis.where(agents_id: agent.id, correct_label: nil)
    @current_agent_tasks = []
    images.each do |analysis|
      image = agent.tasks.where(blob_id: analysis.blob_id).first
      @current_agent_tasks << image
    end
  end
  
  def finished_tasks
    agent = current_agent
    images = Analysis.where(agents_id: agent.id).where.not(correct_label: nil)
    @current_agent_tasks = []
    images.each do |analysis|
      image = agent.tasks.where(blob_id: analysis.blob_id).first
      label = analysis.label
      given_answer = analysis.correct_label
      @current_agent_tasks << { image: image, label: label, answer: given_answer}
    end
  end

  def label_image (id, flag)
    agent = current_agent
    image = agent.tasks.find(id)
    Analysis.find_by(blob_id: image.blob).update(correct_label: flag, time_of_labeling: DateTime.now)
    redirect_to task_active_tasks_path
  end

  def label_correct
    label_image(params[:id], true)
  end

  def label_incorrect
    label_image(params[:id], false)
  end

  def edit_task
    agent = current_agent
    image = agent.tasks.find(params[:id])
    Analysis.find_by(blob_id: image.blob).update(correct_label: nil, time_of_labeling: nil)
    redirect_to task_active_tasks_path
  end

  def image_page
    agent = current_agent
    @image = agent.tasks.find(params[:id])
    @label = Analysis.find_by_blob_id(@image.blob_id).label
  end


end