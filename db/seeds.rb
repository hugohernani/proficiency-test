Admin.create!(
  name: "Hugo Hernani",
  email: "hhernanni@gmail.com",
  password: "123456",
  password_confirmation: "123456")

def register_number
  today = Date.today
  return "PRO#{today.strftime("%y%m%d")}#{Student.count}"
end

Student.create!(
  name: "Hugo Hernani",
  email: "hhernanni@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  activated: true,
  activated_at: Time.zone.now,
  register_number: register_number
  )

Course.create!(
  name: "Metodologias ágeis",
  description: "Estado da arte acerca das metodologias de desenvolvimento ágil. Foco em Scrum."
)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@validprovider.com"
  password = "password"
  Student.create!(name:  name, email: email,
               password:password, password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               register_number: register_number)

  Course.create!(name: "Curso #{n+2}",
              description: "Descrição para o curso #{n+2}")
end
