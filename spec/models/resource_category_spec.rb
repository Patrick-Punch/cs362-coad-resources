require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:res_cat) { build(:resource_category) }
  let(:active_res_cat) {ResourceCategory.create!(active: true, name: "test_name1")}
  let(:inactive_res_cat) {ResourceCategory.create!(active: false, name: "test_name2")}


  it "has a name" do
    expect(res_cat).to respond_to(:name)
  end

  describe "cardinality" do
    it "has and belongs to many organizations" do
      should have_and_belong_to_many(:organizations)
    end

    it "have many tickets" do
      should have_many(:tickets)
    end
  end

  describe "validator tests" do
    specify { expect(res_cat).to validate_presence_of(:name) }
    specify { expect(res_cat).to validate_length_of(:name).is_at_most(255) }
    specify { expect(res_cat).to validate_length_of(:name).is_at_least(1) }
    specify { expect(res_cat).to validate_uniqueness_of(:name).case_insensitive }
  end

  describe "scope tests" do
    it "is active when active" do
      expect(ResourceCategory.active).to include(active_res_cat)
    end

    it "is inactive when inactive" do
      expect(ResourceCategory.active).not_to include(inactive_res_cat)
    end

    describe "member function tests" do
      it "makes an unspecified record when ResourceCategory is unspecified" do
        expect(ResourceCategory.where(name: "Unspecified")).not_to exist
        ResourceCategory.unspecified
        expect(ResourceCategory.where(name: "Unspecified")).to exist
      end

      it "can activate a resource category" do
        res_cat.activate
        expect(res_cat).to be_active
      end

      it "can deactivate a resource category" do
        res_cat.deactivate
        expect(res_cat).not_to be_active
      end

      it "is inactive when not active" do
        expect(active_res_cat).not_to be_inactive
        expect(inactive_res_cat).to be_inactive
      end

      it "returns it's name when it's a string" do
        expect(res_cat.to_s).to eq "test_name"
      end

    end
  end
end
