require 'aws-sdk-s3'
require "google/cloud/vision"
class TaskController < ApplicationController
  def active_tasks
    agent = current_agent
    @task = Task.new
    @task.images.attach(retrieve_images)
    # blob = ActiveStorage::Blob.find(470)
    # @url = rails_blob_url(blob)
  end

  def retrieve_images
    s3 = Aws::S3::Client.new
    bucket_name = 'amazonrails'
    objects = s3.list_objects(bucket: bucket_name).contents
    image_annotator = Google::Cloud::Vision.image_annotator
    blobs = []
    objects.each do |obj|
      image_path = "https://amazonrails.s3.eu-central-1.amazonaws.com/#{obj.key}"
      if obj.key.end_with?('.jpg','.png','.jpeg')
        response = image_annotator.label_detection(image: image_path, max_results: 1)
        response.responses.each do |res|
          res.label_annotations.each do |characteristics|
            label = characteristics.description
            confidence = characteristics.topicality
            if confidence < 0.95
              head_object = s3.head_object(bucket: bucket_name, key: obj.key)
              content_type = head_object.content_type
              existing_blob = ActiveStorage::Blob.find_by(filename: obj.key.split("/").last)
              if existing_blob.nil?
                blob = ActiveStorage::Blob.create_and_upload!(io: s3.get_object(bucket: bucket_name, key: obj.key).body, filename: obj.key.split("/").last, content_type: content_type)
                blob.update(confidence: confidence, label: label)
                blobs << blob
              else
                existing_blob.update(confidence: confidence)
                blobs << existing_blob
              end
            end
          end
        end
      end
    end
      return blobs.sample(1)
  end

  def tasks
  end
end