require('sinatra')
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')

get '/transactions' do #INDEX
  @transactions = Transaction.all()
  erb(:"transactions/index")
end

get '/new_transaction' do #NEW
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end

post '/transactions' do #CREATE
  transaction = Transaction.new(params)
  transaction.save
  redirect to ("/transactions")
end

post '/transactions/:id/delete' do
  Transaction.delete(params[:id])
  redirect to("/transactions")
end
