class Student < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token

  has_many :classrooms, dependent: :destroy
  has_many :courses, through: :classrooms

  before_save :downcase_email
  before_save :generate_register_number
  before_create :create_activation_digest

  enum status: { unregistered: 0, registered: 1}

  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :status, presence: true
  validates :register_number, presence: true, length: {minimum: 10}, allow_nil:true

  has_secure_password
  # has_secure_password guarantee another validation. allow_nil allows updates without changing password
  validates :password, presence: true, length: { minimum: 6}, allow_nil:true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = Student.new_token
    update_attribute(:remember_digest, Student.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def create_reset_digest
    self.reset_token = Student.new_token
    update_attribute(:reset_digest, Student.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def register_in(course)
    classrooms.create(student_id: id, course_id: course.id)
  end

  def unregister_in(course_id)
    classrooms.find_by_course_id(course_id).delete
  end

  def enrolled_in?(course)
    courses.include?(course)
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = Student.new_token
      self.activation_digest = Student.digest(activation_token)
    end

    def generate_register_number
      generated_number = "PRO#{Date.today.strftime("%Y%m%d")}#{Student.count}"
      self.register_number = generated_number
    end

end
