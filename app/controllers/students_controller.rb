class StudentsController < ApplicationController
  before_action :denied_registering_if_logged_in, only: [:new]
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_student, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /students
  # GET /students.json
  def index
    unless (logged_in_as_admin? || logged_in_as_student?)
      flash[:danger] = "Por favor, realize o login."
      redirect_to root_path
    else
      @students = Student.paginate(page: params[:page])
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
    student = params[:id].nil? ? current_student : Student.find(params[:id])
    @registered_courses = student.courses
    @remaining_courses = Course.all - @registered_courses
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html {
          @student.send_activation_email
          if logged_in_as_admin?
            flash[:info] = "Em breve o estudante cadastrado receberá um email de confirmação."
          else
            flash[:info] = "Em breve um email de confirmação será enviado para o email fornecido"
          end
          redirect_to root_url
        }
        format.json { render action: 'show', status: :created, location: @student }
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html {
          flash[:success] = 'Perfil atualizado'
          redirect_to @student
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html {
        flash[:success] = "Estudante apagado."
        redirect_to students_url
      }
      format.json { head :no_content }
    end
  end

  def register_in
    course = Course.find(params[:id])
    student = Student.find(params[:student_id])
    course.register_in(student)
    redirect_to course
  end

  def unregister_in
    course = Course.find(params[:id])
    student = Student.find(params[:student_id])
    course.unregister_in(student_id)
    redirect_to course
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_student
      unless logged_in_as_student?
        store_location
        flash[:danger] = "Por favor, realize o login."
        redirect_to login_url
      end
    end

    def correct_user
      redirect_to(root_path) unless current_user?(@student)
    end

    def admin_user
      redirect_to(root_path) unless logged_in_as_admin?
    end

    def denied_registering_if_logged_in
      if logged_in_as_student? || logged_in_as_admin?
        flash[:danger] = "Não é permitido realizar o cadastro de outro estudante enquanto logado"
        redirect_to root_path
      end
    end


end
