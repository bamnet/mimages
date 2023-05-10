class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_validation if: -> { email.present? } do
    self.email = email.downcase.strip
  end
end
