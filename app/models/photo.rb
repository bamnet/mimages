class Photo < ApplicationRecord
  has_one_attached :photo do |attachable|
    attachable.variant :medium, resize_to_limit: [960, 960]
  end

  def to_param
    uuid
  end
end
