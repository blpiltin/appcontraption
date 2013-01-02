FactoryGirl.define do
  factory :user do
    name     "Brian Piltin"
    email    "brian@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
