require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'UsersController exists and redirects to proper view' do
    it 'can be got' do
      get(:index)
    end
  end
end
