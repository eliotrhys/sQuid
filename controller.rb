require('sinatra')
require('sinatra/reloader')
require( 'pry-byebug' )

require_relative('./models/merchant.rb')

get '/merchants' do #index
  @merchants = Merchant.all()
  erb(:index)
end
