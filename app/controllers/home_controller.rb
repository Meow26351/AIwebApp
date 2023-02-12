
class HomeController < ApplicationController
  def index
  end
  def create
    require "google/cloud/vision"
    image_path = 'C:/Users/tomi2/OneDrive/Desktop/images/tofu.jpg'
    image_annotator = Google::Cloud::Vision.image_annotator
    response = image_annotator.label_detection(
      image:       image_path,
      max_results: 1
    )
    @image = image_path
    response.responses.each do |res|
      res.label_annotations.each do |label|
        @label = label.description
        @confidence = label.topicality
      end
    end
  end
end