FactoryBot.define do
  factory :album do
    name { "MyString" }
    band_id { 1 }
    year { 1 }
    live { false }
  end
end
