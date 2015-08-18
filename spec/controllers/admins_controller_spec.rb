require 'rails_helper'

RSpec.describe AdminsController, :type => :controller do

  let(:valid_attributes) {
    {:name => "Hugo Hernani", :email => "hhernanni@gmail.com",
    :password => "123456", :password_confirmation => "123456"}
  }

  let(:invalid_attributes) {
    {:name => "    ", :email => "hhernanni,@gmail,,com",
    :password => "123456", :password_confirmation => "654321"}
  }

  let(:valid_session) { {} }

  describe "GET new" do
    it "assigns a new admin as @admin" do
      get :new, {}, valid_session
      expect(assigns(:admin)).to be_a_new(Admin)
    end
  end

  describe "Common admin 'member request' route" do

    before(:each) do
      @admin = Admin.create! valid_attributes
    end

    describe "GET show" do
      it "assigns the requested admin as @admin" do
        get :show, {:id => @admin.to_param}, valid_session
        expect(assigns(:admin)).to eq(@admin)
      end
    end

    describe "GET edit" do
      it "assigns the requested admin as @admin" do
        get :edit, {:id => @admin.to_param}, valid_session
        expect(assigns(:admin)).to eq(@admin)
      end
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Admin" do
        expect {
          post :create, {:admin => valid_attributes}, valid_session
        }.to change(Admin, :count).by(1)
      end

      it "assigns a newly created admin as @admin" do
        post :create, {:admin => valid_attributes}, valid_session
        expect(assigns(:admin)).to be_a(Admin)
        expect(assigns(:admin)).to be_persisted
      end

    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved admin as @admin" do
        post :create, {:admin => invalid_attributes}, valid_session
        expect(assigns(:admin)).to be_a_new(Admin)
      end

      it "re-renders the 'new' template" do
        post :create, {:admin => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do

    before(:each) do
      @admin = Admin.create! valid_attributes
      session[:admin_id] = @admin.id # simulating session
    end

    describe "with valid params" do
      let(:new_attributes) {
        {:name => "Hugo Hernani Ferreira da Silva", :email => "hhernanni@gmail.com",
        :password => "123456", :password_confirmation => "123456"}
      }

      it "updates the requested admin" do
        put :update, {:id => @admin.to_param, :admin => new_attributes}, valid_session
        @admin.reload
        expect(@admin.name).to eq new_attributes[:name]
      end

      before(:each) do
        put :update, {:id => @admin.to_param, :admin => valid_attributes}, valid_session
      end

      it "assigns the requested admin as @admin" do
        expect(assigns(:admin)).to eq(@admin)
      end

      it "redirects to the root_path" do
        expect(response).to redirect_to(@admin)
      end
    end

    describe "with invalid params" do

      before(:each) do
        put :update, {:id => @admin.to_param, :admin => invalid_attributes}, valid_session
      end

      it "assigns the admin as @admin" do
        expect(assigns(:admin)).to eq(@admin)
      end

      it "re-renders the 'edit' template" do
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do

    before(:each) do
      @admin = Admin.create! valid_attributes
    end

    it "destroys the requested admin" do
      expect {
        delete :destroy, {:id => @admin.to_param}, valid_session
      }.to change(Admin, :count).by(-1)
    end

    it "redirects to root" do
      delete :destroy, {:id => @admin.to_param}, valid_session
      expect(response).to redirect_to(root_path)
    end
  end

end
