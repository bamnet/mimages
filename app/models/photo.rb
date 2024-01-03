class Photo < ApplicationRecord
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :medium, resize_to_limit: [960, 960]
  end

  validates :title, :presence => true

  before_create do
    require 'securerandom'

    self.uuid = SecureRandom.uuid if uuid.blank?
  end

  def to_param
    uuid
  end

  def location?
    (latitude.present? && longitude.present? && latitude != 0 && longitude != 0)
  end

  def ldjson
    {
      "@context": 'https://schema.org/',
      "@type": 'ImageObject',
      creditText: 'Mimages Project',
      license: 'http://creativecommons.org/licenses/by/4.0/',
      acquireLicensePage: 'http://creativecommons.org/licenses/by/4.0/',
      creator: {
        "@type": 'Person',
        name: 'Brian Michalski'
      },
      copyrightNotice: 'Brian Michalski',
      locationCreated: {
        "@context": 'https://schema.org',
        "@type": 'Place',
        geo: {
          "@type": 'GeoCoordinates',
          latitude:,
          longitude:
        }
      }
    }
  end
end
