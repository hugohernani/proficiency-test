require 'rails_helper'

feature 'Visitor signs up'do

  context 'admin' do

    scenario 'login in and out with valid email and password' do
      admin = FactoryGirl.create(:admin)

      sign_in_with :admin, admin.email, admin.password

      expect(page.current_path).to eq admin_path(admin)
      expect(page).not_to have_css('.alert')
      expect(is_admin_logged_in?).to be_truthy

      click_on 'Sair'
      expect(is_admin_logged_in?).to be_falsey
      expect(page.current_path).to eq root_path

      visit edit_admin_path(admin)
      sign_in_with :admin, admin.email, admin.password
      expect(page.current_path).to eq edit_admin_path(admin)

    end

    scenario 'with invalid email' do
      sign_in_with :admin, 'invalid_email', 'password'

      expect(page.current_path).to eq login_admins_path
      expect(page).to have_css('.alert')
    end

    scenario 'with blank password' do
      sign_in_with :admin, 'valid@example.com', ''

      expect(page.current_path).to eq login_admins_path
      expect(page).to have_css('.alert')
    end

  end

  context 'student' do

    scenario 'login in and out with valid email and password' do
      student = FactoryGirl.create(:student)

      sign_in_with :student, student.email, student.password

      expect(page.current_path).to eq student_path(student)
      expect(page).not_to have_css('.alert')
      expect(is_student_logged_in?).to be_truthy

      click_on 'Sair'
      expect(page.current_path).to eq root_path
      expect(is_student_logged_in?).to be_falsey

      visit edit_student_path(student)
      sign_in_with :student, student.email, student.password
      expect(page.current_path).to eq edit_student_path(student)

    end

    scenario 'with invalid email' do
      sign_in_with :student, 'invalid_email', 'password'

      expect(page.current_path).to eq login_path
      expect(page).to have_css('.alert')
    end

    scenario 'with blank password' do
      sign_in_with :student, 'valid@example.com', ''

      expect(page.current_path).to eq login_path
      expect(page).to have_css('.alert')
    end

  end

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
