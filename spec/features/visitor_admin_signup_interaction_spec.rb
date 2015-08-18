require 'rails_helper'

feature 'Admin signup', :type => :feature do
  scenario 'Openning the form for signing up' do
    visit new_admin_path

    given_there_are_some_fields_to_fill_in
    when_I_fill_in_all_the_fields_with_valid_data
    and_I_click_on_Enviar
    then_I_shall_be_redirected_to_home_on_valid_data

    then_I_shall_see_a_welcome_message

  end

  def given_there_are_some_fields_to_fill_in
    %w[name email password password_confirmation].each do |field_name_id|
      expect(page).to have_css("#admin_#{field_name_id}")
    end
  end

  def when_I_fill_in_all_the_fields_with_valid_data
    fill_in('Nome', :with => 'Hugo Hernani')
    fill_in('Email', :with => 'hhernanni@gmail.com')
    fill_in('Senha', :with => 'my_password')
    fill_in('Confirmação', :with => 'my_password')
  end

  def and_I_click_on_Enviar
    click_on 'Enviar'
  end

  def then_I_shall_be_redirected_to_home_on_valid_data
    expect(page.current_path).to eq root_path
  end

  def then_I_shall_see_a_welcome_message
    expect(page).to have_css(".alert",
                    :text => "Novo administrador. Bem vindo.")
  end

end
