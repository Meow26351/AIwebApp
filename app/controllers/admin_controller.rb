class AdminController < ApplicationController
  def show_agent
    agent = Agent.find(params[:id])
    @show_agents_tasks = agent.tasks
  end
  def agents_work
    @agents = Agent.all
  end

  def analysis
    #get chart1 xy_values
    gon.chart1_xvalues = get_chart1_xvalues
    gon.chart1_yvalues = get_chart1_yvalues

    #get_chart2_xy_values
    gon.chart2_values = get_chart2_yvalues

    #get the percentage of how accurate is the image recognition
    @accuracy_percentage = get_image_recognition_accuracy

  end


  private

  def get_chart1_xvalues
    x_values = Agent.all.where(admin: false).pluck(:email)
    x_values
  end

  def get_chart1_yvalues
    y_values = []
    all_agents = Agent.all.where(admin: false )
    all_agents.each do |agent|
      y_values << Analysis.where(agents_id: agent.id).where.not(correct_label: nil).count
    end
    y_values
  end

  def get_chart2_yvalues
    y_values = []
    all_agents = Agent.all.where(admin: false )
    all_agents.each do |agent|
      y_values << Analysis.where(agents_id: agent.id).where.not(correct_label: nil).count
    end

    work_data_by_agent = {}
    all_agents.each do |agent|
      months = [0,0,0,0,0,0,0,0,0,0,0,0]
      work_done = Analysis.where(agents_id: agent.id).where.not(correct_label: nil)
      work_done.each do |work|
        if work.time_of_labeling
          months[work.time_of_labeling.month - 1] = months[work.time_of_labeling.month - 1] + 1
        end
      end
      work_data_by_agent[agent.email] = months
    end

    work_data_by_agent
  end

  def get_image_recognition_accuracy
    require 'aws-sdk-s3'
    s3 = Aws::S3::Resource.new
    bucket_name = 'amazonrails'
    bucket = s3.bucket(bucket_name)
    image_count = bucket.objects.count { |object| object.key.downcase.end_with?('.jpg', '.jpeg', '.png', '.gif') }

    number_of_incorrect_labels = Analysis.where(correct_label: false).count
    accuracy_percentage = 100 - ((number_of_incorrect_labels.to_f/image_count)*100)
    return accuracy_percentage
  end
end