require 'rails_helper'

RSpec.describe StaticController, :type => :controller do
  # render_views # required

  before :all do
    @base_title = "School System"
  end

  describe "Get #index" do

    it "returns the index template with default title" do
      get :home
      expect(response).to be_success
      expect(response).to render_template :home
    end

    context "visitor perspective" do

    end

    context "student perspective" do
    end

  end


  describe "GET #enroll" do
    it "returns the enroll template" do
      get :enroll
      expect(response).to be_success
      expect(response).to render_template :enroll
    end

    context "visitor perspective" do

    end

    context "student perspective" do

    end

  end

end
