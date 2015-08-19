class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_as_admin, only: [:new, :edit, :update, :destroy]
  before_action :logged_in_as_student, only: [:registered]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.paginate(page: params[:page])
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @students = @course.students.paginate(page: params[:page])

    course = Course.find(params[:id])
    @registered_students = course.students
    @unregistered_students = Student.all - course.students

  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def registered
    @custom_title = "Cursos matriculados"
    student = params[:id].nil? ? current_student : Student.find(params[:id])
    @courses = student.courses.paginate(page: params[:page])
    render 'index'
  end

  # DELETE /courses/unregister
  def unregister
    current_student.unregister_in(params[:id])
    flash[:success] = "Você foi desmatriculado com sucesso."
    redirect_to registered_courses_path
  end

  def register_in
    student = Student.find(params[:id])
    course = Course.find(params[:course_id])
    student.register_in(course)
    redirect_to student
  end

  def unregister_in
    student = Student.find(params[:id])
    course = Course.find(params[:course_id])
    student.unregister_in(course)
    redirect_to student
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description)
    end

    def logged_in_as_admin
      unless logged_in_as_admin?
        store_location
        flash[:danger] = "Você precisa ter poderes administrativos. Por favor, entre como administrador."
        redirect_to login_admins_url
      end
    end

    def logged_in_as_student
      unless logged_in_as_student?
        store_location
        flash[:danger] = "Você precisa ser estudante para ter acesso a esta página. Por favor, entre como estudante."
        redirect_to login_url
      end
    end

end
