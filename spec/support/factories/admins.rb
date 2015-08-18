# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    name "Admin guy"
    email "hhernanni@gmail.com"
    password "password_admin"
    password_confirmation "password_admin"
  end
end
