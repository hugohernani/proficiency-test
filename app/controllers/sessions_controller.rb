class SessionsController < ApplicationController
  before_action :logged_in, only: [:new, :new_admin]

  # new student session
  def new
  end

  # create student session
  def create
    student = Student.find_by_email(params[:session][:email].downcase)
    create_generic student
  end

  # destroy student session
  def destroy
    log_out_student if logged_in_as_student?
    redirect_to root_path
  end

  # new admin session
  def new_admin
  end

  # create admin session
  def create_admin
    admin = Admin.find_by_email(params[:session][:email].downcase)
    create_generic admin, :admin
  end

  # destroy admin session
  def destroy_admin
    log_out_admin if logged_in_as_admin?
    redirect_to root_path
  end

  private

    def create_generic(user, user_type = :student)
      if user && user.authenticate(params[:session][:password])
        puts "User activated? #{user.activated?}" if user.is_a? Student
        if user_type == :admin || user.activated?
          log_in user
          params[:session][:remember_me] == '1' ? remember(user) : forget(user)
          redirect_back_or user
        else
          message = "Conta não ativada. "
          message += "Confira no seu e-mail o link para ativação."
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'Invalid email/password combination'
        user_type == :admin ? render("new_#{user_type}") : render('new')
      end
    end

    def logged_in
      if logged_in_as_admin? || logged_in_as_student?
        store_location
        flash[:danger] = "Por favor, saia da sua conta antes de tentar entrar como outro usuário."
        redirect_to root_path
      end
    end

end
