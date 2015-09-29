FactoryGirl.define do

  factory :event do
    title "Event 1"
    description "The first event of hopefully many, in which we show off our technology"
    code "ABCD1"

    factory :event_two do
      title "My Great Event"
    end
  end

end
