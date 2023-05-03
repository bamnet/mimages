require "securerandom"

class Photo < ApplicationRecord
  has_one_attached :photo do |attachable|
    attachable.variant :medium, resize_to_limit: [960, 960]
  end

  before_create { self.uuid = SecureRandom.uuid if uuid.blank? }

  def to_param
    uuid
  end

  def has_location?
    (!latitude.blank? && !longitude.blank? && latitude != 0 && longitude != 0)
  end
end
