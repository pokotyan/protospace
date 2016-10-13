FactoryGirl.define do

  factory :image do
    image       "test.jpg"
    status      "0"
    association :prototype
  end

end
