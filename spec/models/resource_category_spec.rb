require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:res_cat) { ResourceCategory.new }

  it "exists" do
    ResourceCategory.new
  end

  it "has a name" do
    expect(res_cat).to respond_to(:name)
  end

  it "has and belongs to many organizations" do
    expect(res_cat).to respond_to(:organizations)
  end

  it "has tickets" do
    expect(res_cat).to respond_to(:tickets)
  end
  
end
