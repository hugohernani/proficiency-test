class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    if(params[:user_type] == "student")
      @user = Student.find_by_email(params[:password_reset][:email].downcase)
    elsif(params[:user_type] == "admin")
      @user = Admin.find_by_email(params[:password_reset][:email].downcase)
    end
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email enviado com instruções para reconfigurar a senha"
      redirect_to root_url
    else
      flash.now[:danger] = "Email não encontrado"
      render 'new', :locals => {:user_type => params[:user_type]}
    end
  end

  def edit
  end

  def update
    if params[params[:user_type]][:password].empty?
      flash.now[:danger] = "Senha não pode ser vazia"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Senha reconfigurada com sucesso."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(params[:user_type].to_s).permit(:password, :password_confirmation)
    end

    # Before filters

    def get_user
      user_type = params[:user_type]
      if user_type == "student"
        @user = Student.find_by_email(params[:email])
      elsif user_type == "admin"
        @user = Admin.find_by_email(params[:email])
      end
    end

    # Confirms a valid user.
    def valid_user
      unless (@user && (@user.activated? || @user.is_a?(Admin)) &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Tempo para reconfiguração da senha foi expirado."
        redirect_to new_password_reset_url(user_type:params[:user_type])
      end
    end

end
