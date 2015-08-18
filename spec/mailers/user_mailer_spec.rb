require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do

  before(:all) do
    Student.delete_all # Remove from here....... TODO
    @student = FactoryGirl.create(:student)
  end


  describe "account_activation" do

    let(:mail) {
      UserMailer.account_activation(@student)
    }

    it "renders the headers" do
      expect(mail.subject).to eq("Ativação de conta")
      expect(mail.to).to eq([@student.email])
      expect(mail.from).to eq(["noreply@example.com"])
    end

  end

  describe "password_reset" do

    let(:mail) {
      UserMailer.password_reset(@student)
    }

    it "renders the headers" do
      expect(mail.subject).to eq("Reconfigurar a senha")
      expect(mail.to).to eq([@student.email])
      expect(mail.from).to eq(["noreply@example.com"])
    end

  end

end
