# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    name "Padrões de projeto"
    description "Padrões para uso de boas práticas em programação"
  end

  factory :invalid_course, class: Course do
    name "     "
    description "  " # too small
  end
end
