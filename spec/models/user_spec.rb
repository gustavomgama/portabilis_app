require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: "test@example.com", password: "123123") }

  it "is valid" do
    expect(subject).to be_valid
  end

  it "is invalid" do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it "has a unique email" do
    described_class.create!(email: "test@example.com", password: "12345678")
    expect(subject).not_to be_valid
  end

  it "has role enum with user and admin" do
    expect(User.roles.keys).to include("user", "admin")
  end

  describe "#active_for_authentication?" do
    it "returns false if user is not active" do
      subject.active = false
      expect(subject.active_for_authentication?).to eq(false)
    end

    it "returns true if user is active" do
      subject.active = true
      expect(subject.active_for_authentication?).to eq(true)
    end
  end
end
