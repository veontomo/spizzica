# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'example@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    roles {[FactoryGirl.create(:role)]}
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
