require 'rails_helper'

describe "Company model" do

  before {
    @company = Company.new(name:"Example Company", email: "example@email.com" )
    @company.save
    @company2 = Company.new(name:"Example Company", email: "example2@email.com" )
  }

  describe "when the name is not present" do
    before { @company.name = "" }
    it "should require a name" do
      expect(@company).to_not be_valid
    end
  end

  describe "when the name is too long" do
    before { @company.name = "a"*21 }
      it "should require a shorter name" do
        expect(@company).to_not be_valid
      end
  end

  describe "when the name has already been taken" do
    it "should have a unique name" do
      expect(@company2).to_not be_valid
    end
  end

  describe "when the email is invalid" do
    before { @company.email = "company@email,com" }
    it "should require a valid email" do
      expect(@company).to_not be_valid
    end
  end

  describe "when the email is not present" do
    before { @company.email = "" }
    it "should require a valid email" do
      expect(@company).to_not be_valid
    end
  end

  describe "when the email is already taken" do
    before do
      @company_with_same_email = @company.dup
      @company_with_same_email.email = @company.email.upcase
      @company_with_same_email.save
    end
    it "should have a unique email" do
      expect(@company_with_same_email).to_not be_valid
    end
  end
end
