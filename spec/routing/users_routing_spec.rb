require 'rails_helper'

RSpec.describe 'routes for Users', type: :routing do
  def expect_route(method, url, controller_action, options = {})
    expect(method => url).to route_to(controller_action, options)
  end

  it 'routes to #index get all users' do
    expect_route(:get, '/users', 'users#index')
  end

  it 'routes to #show profile for authenticated user' do
    expect_route(:get, 'profile', 'users#show')
  end

  it 'routes to #show an account for any user' do
    expect_route(:get, 'users/1', 'users#show', id: '1')
  end
end
