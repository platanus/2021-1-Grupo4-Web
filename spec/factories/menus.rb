FactoryBot.define do
  factory :menu do
    name { "Menu #{rand(1..100)}" }
  end
end
