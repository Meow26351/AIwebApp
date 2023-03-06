class Analysis < ApplicationRecord
  belongs_to :blob, class_name: 'ActiveStorage::Blob'
end
