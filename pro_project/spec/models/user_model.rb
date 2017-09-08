require "rails_helper"

RSpec.describe User, :type => :model do
  it "show name and email when we call the method full_name" do
    z = User.create!(name: "abdul", email: "abdul@kreatio.com",role: "Admin",password: "abdul")

    y= User.first
    #expect(y.full_name).to eq("#{z.name} #{z.email}")
    expect(y.full_name).to eq("#{z.name} #{z.email}")
    #expect(y.email).not_to be_nil
    expect(y.email).not_to be_nil
    expect(y.email).to match /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
   end
end