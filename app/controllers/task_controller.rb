require 'aws-sdk-s3'
require "google/cloud/vision"
class TaskController < ApplicationController
  def active_tasks
    agent = current_agent
    images = Analysis.where(agents_id: current_agent.id, correct_label: nil)
    @current_agent_tasks = []
    images.each do |analysis|
      image = agent.tasks.where(blob_id: analysis.blob_id)
      label = analysis.label
      @current_agent_tasks << { image: image, label: label }
    end
  end
  def finished_tasks
    agent = current_agent
    images = Analysis.where(agents_id: current_agent.id).where.not(correct_label: nil)
    @current_agent_tasks = []
    @current_agent_tasks = []
    images.each do |analysis|
      image = agent.tasks.where(blob_id: analysis.blob_id)
      label = analysis.label
      given_answer = analysis.correct_label
      @current_agent_tasks << { image: image, label: label, answer: given_answer}
    end
  end
  def label_correct
    agent = current_agent
    image = agent.tasks.find(params[:id])
    Analysis.find_by(blob_id: image.blob).update(correct_label: true, time_of_labeling: DateTime.now)
    redirect_to root_path
  end

  def label_incorrect
    agent = current_agent
    image = agent.tasks.find(params[:id])
    Analysis.find_by(blob_id: image.blob).update(correct_label: false, time_of_labeling: DateTime.now)
    redirect_to root_path
  end


end