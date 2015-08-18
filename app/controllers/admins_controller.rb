class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_admin, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @admins = Admin.all
  end

  def show
  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.valid? @admin.save
      log_in @admin
      flash[:info] = "Novo administrador. Bem vindo."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @admin.update(admin_params)
      flash[:success] = 'Admin was successfully updated.'
      redirect_to @admin
    else
      render 'edit'
    end
  end


  def destroy
    @admin.destroy
    flash[:success] = "administrador deletado"
    redirect_to root_path
  end


  private

    def set_admin
      @admin = Admin.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_admin
      unless logged_in_as_admin?
        store_location
        flash[:danger] = "Por favor, realize o login como administrador."
        redirect_to login_admins_path
      end
    end

    def correct_user
      redirect_to(root_path) unless current_user?(@admin)
    end

end
