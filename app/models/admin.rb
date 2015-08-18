class Admin < ActiveRecord::Base

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password
  # has_secure_password guarantee another validation. allow_nil allows updates without changing password
  validates :password, presence: true, length: { minimum: 6}, allow_nil:true


  private

    def downcase_email
      self.email = email.downcase
    end


end
