class StaticController < ApplicationController
  def home
    if logged_in_as_admin?
      @count_courses = Course.count
      @count_students = Student.count
    elsif logged_in_as_student?
      @count_courses = Course.count # TODO Not final implementation
    end
  end

  def enroll
  end
end
