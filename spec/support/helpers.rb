def is_student_logged_in?
  !page.driver.request.session[:student_id].nil?
end

def is_admin_logged_in?
  !page.driver.request.session[:admin_id].nil?
end
