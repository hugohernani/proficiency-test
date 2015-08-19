class Course < ActiveRecord::Base

  has_many :classrooms, dependent: :destroy
  has_many :students, through: :classrooms

  validates :name, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 1000}

  default_scope -> { order(created_at: :desc) }


  def register_in(student)
    classrooms.create(course_id: id, student_id: student.id)
  end

  def unregister_in(student_id)
    classrooms.find_by_student_id(student_id).delete
  end


end
