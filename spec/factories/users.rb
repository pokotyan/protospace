FactoryGirl.define do

  factory :user do
    email                {Faker::Internet.email}
    name                 "soga"
    password             "00000000"
    password_confirmation "00000000"
  end

end
