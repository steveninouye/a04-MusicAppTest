FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    session_token { "MyString" }
    activated { false }
  end
end
