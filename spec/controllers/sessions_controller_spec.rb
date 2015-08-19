require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "Common requests" do
    it "returns http success on all get request " do
      get :new
      expect(response).to be_success
      get :new_admin
      expect(response).to be_success
    end
  end


  describe "Student rest http interaction" do

    before(:all) do
      Student.delete_all # workaround for ActiveRecord/Rspec problem not detected yet. TODO
    end

    let(:valid_attributes){
      FactoryGirl.attributes_for(:student)
    }

    let(:invalid_attributes){
      FactoryGirl.attributes_for(:invalid_student)
    }

    it "should redirects back to the student login page when passing session_invalid_attributes" do
      post :create, {session: invalid_attributes}
      expect(response).to be_success
      expect(response).to render_template 'new'
      expect(flash).not_to be_empty
    end

    it "should redirects to the requested page when passing\
    session_valid_attributes for before hand created student" do
      student = sign_up :student, valid_attributes

      session[:forwarding_url] = edit_student_path(student) # simulating sessions

      post :create, {session: valid_attributes}
      expect(response).to redirect_to edit_student_path(student)
    end

    it "should receive nil from session[:student_id] on destroy" do
      student = sign_up :student, valid_attributes

      session[:student_id] = student.id # simulation evaluation on session

      delete :destroy
      expect(session[:student_id]).to be_nil
      expect(response).to redirect_to root_path
    end

  end

  describe "Admin rest http interaction" do

    let(:valid_attributes){
      FactoryGirl.attributes_for(:admin)
    }

    let(:invalid_attributes){
      FactoryGirl.attributes_for(:invalid_admin)
    }

    it "should redirects back to the admin login page when passing session_invalid_attributes" do
      post :create_admin, {session: invalid_attributes}
      expect(response).to be_success
      expect(response).to render_template 'new_admin'
      expect(flash).not_to be_empty
    end

    it "should redirects to the requested page when passing\
    session_valid_attributes for before hand created admin" do
      admin = sign_up :admin, valid_attributes

      session[:forwarding_url] = edit_admin_path(admin) # simulating sessions

      post :create_admin, {session: valid_attributes}
      expect(response).to redirect_to root_path
    end

    it "should be nil on session[:admin_id] on destroy and return to root_path" do
      admin = sign_up :admin, valid_attributes

      session[:admin_id] = admin.id # simulation evaluation on session

      delete :destroy_admin
      expect(session[:admin_id]).to be_nil
      expect(response).to redirect_to root_path
    end

  end

  #helpers
  def sign_up(user_type, user_attributes)
    if user_type == :admin
      Admin.create!(user_attributes)
    elsif user_type == :student
      Student.create!(user_attributes)
    end
  end

end
