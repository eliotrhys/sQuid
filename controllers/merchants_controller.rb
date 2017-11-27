require('sinatra')
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('../models/merchant.rb')

get '/merchants' do #index
  @merchants = Merchant.all()
  erb(:index)
end
