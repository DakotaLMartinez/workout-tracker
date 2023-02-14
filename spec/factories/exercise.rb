FactoryGirl.define do 
  factory :exercise do
    name { "Bench Press" }
    user { create :user }
  end
end