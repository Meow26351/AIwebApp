class TaskController < ApplicationController
  def active_tasks
    agent = current_agent
    @task = agent.tasks.create!
    @task.images.attach(retrieve_images)
    blob = ActiveStorage::Blob.find(470)
    @url = rails_blob_url(blob)
  end
  def retrieve_images
    require 'aws-sdk-s3'
    s3 = Aws::S3::Client.new
    objects = s3.list_objects(bucket: 'amazonrails').contents
    blobs = []
    objects.each do |obj|
      if obj.key.end_with?('.jpg','.png','.jpeg')
        head_object = s3.head_object(bucket: 'amazonrails', key: obj.key)
        content_type = head_object.content_type
        existing_blob = ActiveStorage::Blob.find_by(key: obj.key)
        existing_blob.present?
        blob = ActiveStorage::Blob.create_and_upload!(
          io: s3.get_object(bucket: 'amazonrails', key: obj.key).body,
          filename: obj.key.split("/").last,
          content_type: content_type
        )
        end
        blobs << blob
    end
    return blobs
    end


  def tasks
  end
end