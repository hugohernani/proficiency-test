# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student do
    name "Hugo Hernani"
    email "noreply@example.com"
    password "password_example"
    password_confirmation "password_example"
    status 1
    # activated true
    # activated_at Time.zone.now
  end
end
