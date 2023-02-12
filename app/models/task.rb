class Task < ApplicationRecord
  has_many_attached :images, service: :amazon do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end

  belongs_to :agent
end
