require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DashboardHelper, type: :helper do
  describe "dashboard helper" do
    let(:user) { double("User") }

    it "returns admin_dashboard" do
      expect(user).to receive(:admin?).and_return(true)
      result = helper.dashboard_for(user)
      expect(result).to eq('admin_dashboard')
    end

    it "returns organization_submitted_dashboard" do
      organization = double("Organization", submitted?: true, approved?: false)
      expect(user).to receive(:admin?).and_return(false)
      expect(user).to receive(:organization).and_return(organization)
      result = helper.dashboard_for(user)
      expect(result).to eq('organization_submitted_dashboard')
    end

    it "returns organization_approved_dashboard" do
      organization = double("Organization", submitted?: false, approved?: true)
      expect(user).to receive(:admin?).and_return(false)
      allow(user).to receive(:organization).and_return(organization)
      result = helper.dashboard_for(user)
      expect(result).to eq('organization_approved_dashboard')
    end

    it "returns create_application_dashboard" do
      expect(user).to receive(:admin?).and_return(false)
      allow(user).to receive(:organization).and_return(nil)
      result = helper.dashboard_for(user)
      expect(result).to eq('create_application_dashboard')
    end
  end
end
