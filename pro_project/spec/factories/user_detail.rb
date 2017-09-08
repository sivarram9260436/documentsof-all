
FactoryGirl.define do
  factory :user do
    name "abdul"
    email "abdul@kreatio.com"
    password "abdul"
    role "Admin"
  end
end
  FactoryGirl.define do
  factory :bala , class: User do
    name "raj"
    email "raj@kreatio.com"
    password "raj@kreatio.com"
    role "Admin"
  end
end
