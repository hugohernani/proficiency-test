module SessionsHelper

  # Logs in the given admin
  def log_in(user)
    if user.is_a? Student
      session[:student_id] = user.id
    elsif user.is_a? Admin
      session[:admin_id] = user.id
    end
  end

  def remember(user)
    user.remember
    if user.is_a? Student
      cookies.permanent.signed[:student_id] = user.id
      cookies.permanent[:student_remember_token] = user.remember_token
    elsif user.is_a? Admin
      cookies.permanent.signed[:admin_id] = user.id
      cookies.permanent[:admin_remember_token] = user.remember_token
    end
  end

  def forget(user)
    user.forget
    if user.is_a? Student
      cookies.delete(:student_id)
      cookies.delete(:student_remember_token)
    elsif user.is_a? Admin
      cookies.delete(:admin_id)
      cookies.delete(:admin_remember_token)
    end
  end

  def log_out_student
    forget(current_student)
    session.delete(:student_id)
    @current_student = nil
  end

  def log_out_admin
    forget(current_admin)
    session.delete(:admin_id)
    @current_admin = nil
  end

  # Returns the current logged-in admin (if any).
  def current_admin
    if(admin_id = session[:admin_id])
      @current_admin ||= Admin.find_by(id: admin_id)
    elsif (admin_id = cookies.signed[:admin_id])
      admin = Admin.find_by_id(admin_id)
      if admin && admin.authenticated?(cookies[:admin_remember_token])
        logged_in_as_admin
        @current_admin = admin
      end
    end
  end

  # Returns true if the admin is logged in, false otherwise.
  def logged_in_as_admin?
    !current_admin.nil?
  end

  # Returns the current logged-in admin (if any).
  def current_student
    if(student_id = session[:student_id])
      @current_student ||= Student.find_by(id: student_id)
    elsif (student_id = cookies.signed[:student_id])
      student = Student.find_by_id(student_id)
      if student && student.authenticated?(:remember, cookies[:student_remember_token])
        logged_in_as_student
        @current_student = student
      end
    end
  end

  # Returns true if the admin is logged in, false otherwise.
  def logged_in_as_student?
    !current_student.nil?
  end

  def current_user?(user)
    if user.is_a? Student
      user == current_student
    elsif user.is_a? Admin
      user == current_admin
    end
  end

  def redirect_back_or(default)
    puts "In redirect_back_or: #{session[:forwarding_url]}"
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end
