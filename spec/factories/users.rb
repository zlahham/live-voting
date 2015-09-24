FactoryGirl.define do
  factory :user do
    email 'test_user@test.com'
    password 'testtest'
    password_confirmation 'testtest'

    factory :user_two do
      email 'test_user_two@test.com'
    end
    
    factory :user_three do
      email 'test_user_three@test.com'
    end
  end
end
