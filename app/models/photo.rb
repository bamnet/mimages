class Photo < ApplicationRecord
  def to_param
    uuid
  end
end
