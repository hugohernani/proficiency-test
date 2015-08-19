require 'rails_helper'

RSpec.describe StaticController, :type => :controller do

  describe "Get #index" do

    it "returns the index template with default title" do
      get :home
      expect(response).to be_success
      expect(response).to render_template :home
    end

  end

end
