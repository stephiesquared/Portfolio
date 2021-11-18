require 'rails_helper'

RSpec.describe User, type: :model do

  context "user validation tests" do
    it "ensures the username is present" do
      user = User.new(password: "test123")
      expect(user.valid?).to eq(false)
    end

    it "ensures the password is present" do
      user = User.new(email: "tester@testing.com")
      expect(user.valid?).to eq(false)
    end
    
    it "should be able to save user" do
      user = User.new(email: "tester@testing.com", password: "test123")
      expect(user.save).to eq(true)
    end
  end


  context "scopes tests" do
    let(:user1) { { email: "tester1@testing.com", password: "test123" } }
    let(:user2) { { email: "tester2@testing.com", password: "test123" } }
    let(:user3) { { email: "tester3@testing.com", password: "test123" } }
    before(:each) do
      User.create(user1)
      User.create(user2)
      User.create(user3)
    end

    it "should return all users" do
      expect(User.count).to eq(3)
    end
  end


end
