require 'rails_helper'

RSpec.describe Student, :type => :model do

  before(:all) do
    Student.delete_all # workaround for ActiveRecord/Rspec. Problem not detected yet. TODO
  end

  before(:each) do
    @student = FactoryGirl.build(:student)
  end

  it "has a valid factory" do
    expect(@student).to be_valid
  end

  it "should be invalid without a name" do
    @student.name = "     "
    expect(@student).not_to be_valid
  end

  it "is expected not to have a name with length longer than 50 characters" do
    @student.name = "a" * 51
    expect(@student).not_to be_valid
  end

  it "should be invalid without email address" do
    @student.email = "    "
    expect(@student).not_to be_valid
  end

  it "should be invalid with too long email address" do
    @student.email = "a" * 250 + "@example.com"
    expect(@student).not_to be_valid
  end

  it "should accept valid email" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @student.email = valid_address
      expect(@student).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "should not accept invalid email" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @student.email = invalid_address
      expect(@student).not_to be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "email addresses should be unique" do
    duplicated_student = @student.dup
    duplicated_student.email = @student.email.upcase # checking for case-insensitivity
    @student.save
    expect(duplicated_student).not_to be_valid
  end

  it "password should be present (nonblank)" do
    @student.password = @student.password_confirmation = " " * 6
    expect(@student).not_to be_valid
  end

  it "password should have a minimum length" do
    @student.password = @student.password_confirmation = "a" * 5
    expect(@student).not_to be_valid
  end

  it "should be invalid without a register_number" do
    @student.register_number = " " * 10
    expect(@student).not_to be_valid
  end

  it "should be invalid with a register_number with length smaller than 10" do
    @student.register_number = "a" * 9
    expect(@student).not_to be_valid
  end

  it "should have a register_number" do
    expect(@student.register_number).not_to be_empty
  end


end
