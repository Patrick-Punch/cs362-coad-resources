require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  it 'index' do
    get(:index)
    expect(response).to be_successful
  end

end
