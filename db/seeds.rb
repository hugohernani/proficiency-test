Admin.create!(
  name: "Hugo Hernani",
  email: "hhernanni@gmail.com",
  password: "123456",
  password_confirmation: "123456")

Student.create!(
  name: "Hugo Hernani",
  email: "hhernanni@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  activated: true,
  activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@validprovider.com"
  password = "password"
  Student.create!(name:  name, email: email,
               password:password, password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
