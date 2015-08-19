require 'rails_helper'

RSpec.describe StudentsController, :type => :controller do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:student)
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:invalid_student)
  }

  let(:valid_session) { {} }

  describe "GET show" do
    it "assigns the requested student as @student" do
      student = Student.create! valid_attributes
      get :show, {:id => student.to_param}, valid_session
      expect(assigns(:student)).to eq(student)
    end
  end

  describe "GET new" do
    it "assigns a new student as @student" do
      get :new, {}, valid_session
      expect(assigns(:student)).to be_a_new(Student)
    end
  end

  describe "GET edit" do
    it "assigns the requested student as @student" do
      student = Student.create! valid_attributes
      get :edit, {:id => student.to_param}, valid_session
      expect(assigns(:student)).to eq(student)
    end
  end

  describe "POST create" do
    describe "with valid params" do

      it "creates a new Student" do
        expect {
          post :create, {:student => valid_attributes}, valid_session
        }.to change(Student, :count).by(1)
      end

      it "assigns a newly created student as @student" do
        post :create, {:student => valid_attributes}, valid_session
        expect(assigns(:student)).to be_a(Student)
        expect(assigns(:student)).to be_persisted
      end

      it "redirects to root path due to waiting for activation" do
        post :create, {:student => valid_attributes}, valid_session
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved student as @student" do
        post :create, {:student => invalid_attributes}, valid_session
        expect(assigns(:student)).to be_a_new(Student)
      end

      it "re-renders the 'new' template" do
        post :create, {:student => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do

    before(:each) do
      @student = Student.create! valid_attributes
      session[:student_id] = @student.id # simulating session
    end

    describe "with valid params" do
      let(:new_attributes) {
        {
          :name => "Hugo Hernani Ferreira da Silva",
          :email => "new_address@gmail.com",
          :password => "new_password",
          :password_confirmation => "new_password"}
      }

      it "updates the requested student" do
        put :update, {:id => @student.to_param, :student => new_attributes}, valid_session
        @student.reload
        expect(@student.name).to eq new_attributes[:name]
      end

      it "assigns the requested student as @student" do
        put :update, {:id => @student.to_param, :student => valid_attributes}, valid_session
        expect(assigns(:student)).to eq(@student)
      end

      it "redirects to the student" do
        put :update, {:id => @student.to_param, :student => valid_attributes}, valid_session
        expect(response).to redirect_to(@student)
      end
    end

    describe "with invalid params" do
      it "assigns the student as @student" do
        put :update, {:id => @student.to_param, :student => invalid_attributes}, valid_session
        expect(assigns(:student)).to eq(@student)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => @student.to_param, :student => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    context "required to be logged in as admin" do

      before(:each) do
        admin_attributes = {name: "Hugo", email: "valid@email.com",
            password: "123456", password_confirmation: "123456"}
        admin = Admin.create! admin_attributes
        session[:admin_id] = admin.id # simulating session
      end

      it "destroys the requested student" do
        student = Student.create! valid_attributes
        expect {
          delete :destroy, {:id => student.to_param}, valid_session
        }.to change(Student, :count).by(-1)
      end

      it "redirects to the students list" do
        student = Student.create! valid_attributes
        delete :destroy, {:id => student.to_param}, valid_session
        expect(response).to redirect_to(students_url)
      end

    end

    it "does not destroy the requested student due to not be a admin user" do
      student = Student.create! valid_attributes
      expect {
        delete :destroy, {:id => student.to_param}, valid_session
      }.not_to change(Student, :count)
    end

    it "redirects to the root_path" do
      student = Student.create! valid_attributes
      delete :destroy, {:id => student.to_param}, valid_session
      expect(response).to redirect_to(root_path)
    end


  end

end
