require 'rails_helper'

RSpec.describe Admin, :type => :model do

  before(:each) do
    @admin = FactoryGirl.build(:admin)
  end

  it "has a valid factory" do
    expect(@admin).to be_valid
  end

  it "should be invalid without a name" do
    @admin.name = "     "
    expect(@admin).not_to be_valid
  end

  it "is expected not to have a name with length longer than 50 characters" do
    @admin.name = "a" * 51
    expect(@admin).not_to be_valid
  end

  it "should be invalid without email address" do
    @admin.email = "    "
    expect(@admin).not_to be_valid
  end

  it "should be invalid with too long email address" do
    @admin.email = "a" * 250 + "@example.com"
    expect(@admin).not_to be_valid
  end

  it "should accept valid email" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @admin.email = valid_address
      expect(@admin).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "should not accept invalid email" do
  invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @admin.email = invalid_address
      expect(@admin).not_to be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "email addresses should be unique" do
    duplicated_student = @admin.dup
    duplicated_student.email = @admin.email.upcase # checking for case-insensitivity
    @admin.save
    expect(duplicated_student).not_to be_valid
  end

  it "password should be present (nonblank)" do
    @admin.password = @admin.password_confirmation = " " * 6
    expect(@admin).not_to be_valid
  end

  it "password should have a minimum length" do
    @admin.password = @admin.password_confirmation = "a" * 5
    expect(@admin).not_to be_valid
  end

end
