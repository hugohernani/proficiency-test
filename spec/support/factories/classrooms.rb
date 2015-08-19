# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :classroom do
    student Student.first
    course Course.first
    entry_at "2015-08-19 04:56:31"
  end
end
