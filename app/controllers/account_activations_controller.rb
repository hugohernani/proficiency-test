class AccountActivationsController < ApplicationController

  def edit
    user = Student.find_by_email(params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Conta ativada!"
      redirect_to user
    else
      flash[:danger] = "Inválido link de ativação"
      redirect_to root_url
    end
  end

end
