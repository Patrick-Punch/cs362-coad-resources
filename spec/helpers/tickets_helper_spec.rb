require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TIcketsHelper. For example:
#
# describe TIcketsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TicketsHelper, type: :helper do
  describe "format helper" do

    it "formats a valid US phone number" do
      expect(PhonyRails).to receive(:normalize_number).with("555-123-4567", country_code: 'US').and_return("+15551234567")
      result = helper.format_phone_number("555-123-4567")
      expect(result).to eq("+15551234567")
    end

    it "handles an invalid phone number" do
      expect(PhonyRails).to receive(:normalize_number).with("invalid", country_code: 'US').and_return(nil)
      result = helper.format_phone_number("invalid")
      expect(result).to be_nil
    end

    it "formats an existing international phone number" do
      expect(PhonyRails).to receive(:normalize_number).with("+1-555-123-4567", country_code: 'US').and_return("+15551234567")
      result = helper.format_phone_number("+1-555-123-4567")
      expect(result).to eq("+15551234567")
    end

    it "handles an empty string" do
      expect(PhonyRails).to receive(:normalize_number).with("", country_code: 'US').and_return(nil)
      result = helper.format_phone_number("")
      expect(result).to be_nil
    end

    it "handles a nil input" do
      expect(PhonyRails).to receive(:normalize_number).with(nil, country_code: 'US').and_return(nil)
      result = helper.format_phone_number(nil)
      expect(result).to be_nil
    end
  end
end
