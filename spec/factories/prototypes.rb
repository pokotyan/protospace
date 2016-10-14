FactoryGirl.define do

  factory :prototype, class: Prototype do
    title                "test"
    catch_copy           "test_catch_copy"
    concept              "test_concept"
    user

    #after buildはFactoryGirl.create後も実行される.
    #逆にafter createはFactoryGirl.build後は実行されないためコールバックはbuildとcreateならbuildの方が便利
    after(:build) do |prototype|
      [ :main_image, :sub_image, :sub_image, :sub_image ].each do |image|
        prototype.images << build(image,prototype_id: prototype.id)
      end
    end

    trait :with_likes do
      after(:build) do |prototype|
        prototype.likes << build(:like, prototype_id: prototype.id, user_id:prototype.user.id)
      end
    end

    trait :is_missing_a_title do
      title nil
    end

    trait :is_missing_a_catch_copy do
      catch_copy nil
    end

    trait :is_missing_a_concept do
      concept nil
    end

  end

end
