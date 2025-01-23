require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let(:res_cat) { ResourceCategory.new }

  it "has a name" do
    expect(res_cat).to respond_to(:name)
  end

  ## CARDINALITY

  it "has and belongs to many organizations" do
    should have_and_belong_to_many(:organizations)
  end

  it "have many tickets" do
    should have_many(:tickets)
  end

end
