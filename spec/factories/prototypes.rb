FactoryGirl.define do

  factory :prototype do
    title                "test"
    catch_copy           "test_catch_copy"
    concept              "test_concept"
    association :user
  end

end
