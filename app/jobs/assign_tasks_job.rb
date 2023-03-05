class AssignTasksJob < ApplicationJob
  queue_as :default

  def perform
    puts 'assigning starts...'
    all_agents = Agent.all
    retrieve_images
    all_agents.each do |agent|
      count = 0
      if agent.admin == false
        while count < 3 && agent.tasks.length < 5
          if ActiveStorage::Blob.where(assigned: false).exists?
            random_image = ActiveStorage::Blob.where(assigned: false).sample(1).first
            random_image.update(assigned: true)
            agent.tasks.attach(random_image)
          else
            break
          end
          count = count + 1
        end
      end
    end
  end

  private

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
            if confidence < 0.97
              head_object = s3.head_object(bucket: bucket_name, key: obj.key)
              content_type = head_object.content_type
              existing_blob = ActiveStorage::Blob.find_by(filename: obj.key.split("/").last)
              if existing_blob.nil?
                blob = ActiveStorage::Blob.create_and_upload!(io: s3.get_object(bucket: bucket_name, key: obj.key).body, filename: obj.key.split("/").last, content_type: content_type)
                Analysis.create(confidence: confidence, label: label, blob_id: blob.id)
                blob.update(confidence: confidence, label: label)
                blobs << blob
              else
                Analysis.create(confidence: confidence, label: label, blob_id: existing_blob)
                existing_blob.update(confidence: confidence, label: label)
                blobs << existing_blob
              end
            end
          end
        end
      end
    end
    return blobs
  end
end
