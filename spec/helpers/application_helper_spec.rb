require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "application helper" do
    let(:base_title) { 'Disaster Resource Network' }

    it "returns the base title" do
      expect(helper.full_title('')).to eq(base_title)
    end

    it "returns expected title" do
      page_title = 'About Us'
      expected_title = "#{page_title} | #{base_title}"
      expect(helper.full_title(page_title)).to eq(expected_title)
    end
  end
end
