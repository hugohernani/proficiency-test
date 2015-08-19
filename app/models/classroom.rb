class Classroom < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  validates :student_id, presence: true
  validates :course_id, presence: true
  
end
