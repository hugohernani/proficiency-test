require 'rails_helper'

RSpec.describe Classroom, :type => :model do

  before(:all) do
    Classroom.delete_all # workaround for ActiveRecord/Rspec. Problem not detected yet. TODO
    Student.delete_all
    Course.delete_all
    FactoryGirl.create(:student)
    FactoryGirl.create(:course)
  end

  before(:each) do
    @classroom = FactoryGirl.build(:classroom)
  end


  it "should be valid" do
    expect(@classroom).to be_valid
  end

  it "should require a student_id" do
    @classroom.student_id = nil
    expect(@classroom).not_to be_valid
  end

  it "should require a course_id" do
    @classroom.course_id = nil
    expect(@classroom).not_to be_valid
  end

end
