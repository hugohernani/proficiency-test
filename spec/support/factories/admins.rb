# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    name "Admin guy"
    email "hhernanni@gmail.com"
    password "password_admin"
    password_confirmation "password_admin"
  end

  factory :invalid_admin, class: Admin do
    name "     "
    email "noreply@example,com"
    password "password_example1"
    password_confirmation "password_example2"
  end


end
