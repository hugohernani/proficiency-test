require 'rails_helper'

feature 'User lists'do

  before(:all) do
    Student.delete_all # workaround for ActiveRecord/Rspec. Problem not detected yet. TODO
  end

  scenario 'check students list by pagination' do
    student = FactoryGirl.create(:student)
    sign_in_with :student, student.email, student.password

    visit "#{students_path}?page=1"
    all_students_link = page.all(:css, 'ul[class=users] li a')
    expect(all_students_link.length).to eq Student.count
    Student.paginate(page: 1).each_with_index do |student, index|
      expect(student.name).to eq all_students_link[index].text
    end
  end

  # scenario 'check admin list by pagination' do
  #   admin = FactoryGirl.create(:admin)
  #   sign_in_with :admin, admin.email, admin.password
  #
  #   visit "#{admins_path}?page=1"
  #   admins_link = page.all(:css, 'ul[class=users] li a')
  #   expect(admins_link.length).to eq Admin.count
  #   Admin.paginate(page: 1).each_with_index do |admin, index|
  #     expect(admin.name).to eq admins_link[index].text
  #   end
  # end

  #helpers
  def sign_in_with(user_type, email, password)
    if user_type == :admin
      visit login_admins_path
    elsif user_type == :student
      visit login_path
    end
    fill_in 'Email', with: email
    fill_in 'Senha', with: password

    click_button 'Entrar'
  end

end
