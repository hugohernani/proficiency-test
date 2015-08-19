require 'rails_helper'

RSpec.describe Course, :type => :model do

  before(:all) do
    @course = FactoryGirl.create(:course)
  end

  it "has a valid factory" do
    expect(@course).to be_valid
  end

  it "should be invalid without a name" do
    @course.name = "     "
    expect(@course).not_to be_valid
  end

  it "is expected not to have a name with length longer than 50 characters" do
    @course.name = "a" * 51
    expect(@course).not_to be_valid
  end

  it "is expected not to have a name with length smaller than 5 characters" do
    @course.name = "ssss"
    expect(@course).not_to be_valid
  end

  it "should be invalid without description" do
    @course.description = "    "
    expect(@course).not_to be_valid
  end

  it "is expected not to have a description with length longer than 1000" do
    @course.description = "a" * 1000 + "@example.com"
    expect(@course).not_to be_valid
  end

  it "is expected not to have a description with length smaller than 10" do
    @course.description = "dsdsdsdsd"
    expect(@course).not_to be_valid
  end

  it "should return most recently created first" do
    attributes = {name: "New Course", description: "Description for the new course"}
    most_recent_course = Course.create!(attributes)
    expect(Course.count).to satisfy { |value|
      value >= 2 # check for more than 1 course in the database
    }
    expect(Course.first).to eq most_recent_course
  end

end
