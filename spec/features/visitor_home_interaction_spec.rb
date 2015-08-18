require 'rails_helper'

feature 'Homepage', :type => :feature do
  scenario 'Openning the index as a visitor' do
    visit root_path

    given_I_am_a_visitor
    then_I_shall_see_some_get_in_links
    when_I_click_on_Criar_conta_de_administrador
    then_I_shall_be_redirected_to_new_admin_path
    or_when_I_click_on_Entrar_como_administrador
    then_I_shall_be_redirected_to_login_admins_path
    or_when_I_click_on_Cadastrar_se_como_estudante
    then_I_shall_be_redirected_to_new_student_path

  end

  def given_I_am_a_visitor
    expect(page).to have_content("visitante")
  end

  def then_I_shall_see_some_get_in_links
    expect(page).to have_css("a", :text => "Entrar como admin")
    expect(page).to have_css("a", :text => "Criar conta admin")
    expect(page).to have_css("a", :text => "Cadastrar-se como estudante")
  end

  def when_I_click_on_Criar_conta_de_administrador
    click_on 'Criar conta admin'
  end

  def then_I_shall_be_redirected_to_new_admin_path
    expect(page.current_path).to eq new_admin_path
  end

  def or_when_I_click_on_Entrar_como_administrador
    visit root_path
    click_on 'Entrar como admin'
  end

  def then_I_shall_be_redirected_to_login_admins_path
    expect(page.current_path).to eq login_admins_path
  end

  def or_when_I_click_on_Cadastrar_se_como_estudante
    visit root_path
    click_on 'Cadastrar-se como estudante'
  end

  def then_I_shall_be_redirected_to_new_student_path #login_student_path
    expect(page.current_path).to eq new_student_path
  end

end
