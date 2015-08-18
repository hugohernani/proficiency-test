require 'rails_helper'

RSpec.describe StaticController, :type => :controller do

  render_views # Required to render views on controller type test

  before :all do
    @base_title = "Sistema escolar"
  end


  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response).to be_success
      expect(response).to have_css('title', :text => @base_title)
    end
  end

  describe "GET enroll" do
    it "returns http success" do
      get :enroll
      expect(response).to be_success
    end
  end

end
