class Course < ActiveRecord::Base
  validates :name, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 1000}

  default_scope -> { order(created_at: :desc) }
  

end
