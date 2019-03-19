require 'rails_helper'

describe "Address model"  do
  before {
    @address = Address.new(short_address: "shortAddr1", full_address: "longAddr1",
                     zipcode: 12345, country: "country1")
    @address_short = Address.new(short_address: "shortAddr1", full_address: "longAddr2",
                     zipcode: 12346, country: "country1")
  }

  describe "when the short address is not present" do
    before { @address.short_address = "" }
    it "should require a short address" do
      expect(@address).to_not be_valid
    end
  end

  describe "when the short address is too long" do
    before { @address.short_address = "a"*16 }
    it "should require a shorter short address" do
      expect(@address).to_not be_valid
    end
  end

  describe "when the full address is too long" do
    before { @address.full_address = "a"*26 }
    it "should require a shorter full address" do
      expect(@address).to_not be_valid
    end
  end

  describe "when the city name is too long" do
    before { @address.city = "a"*16 }
    it "should require a shorter city name" do
      expect(@address).to_not be_valid
    end
  end

  describe "when the zipcode is not an integer" do
    before { @address.zipcode = "abcde"}
    it "should require a valid zipcode" do
      expect(@address).to_not be_valid
    end
  end

  describe "when the zipcode is too short" do
    before { @address.zipcode = 11111}
    it "should require a longer zipcode" do
      expect(@address).to_not be_valid
    end
  end

  describe "when the zipcode is too long" do
    before { @address.zipcode = 1111111}
    it "should require a shorter zipcode" do
      expect(@address).to_not be_valid
    end
  end

  describe "when the country is not present" do
    before { @address.country = "" }
    it "should require a short address" do
      expect(@address).to_not be_valid
    end
  end


end
