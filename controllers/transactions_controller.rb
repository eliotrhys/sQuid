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

post '/transactions/:id/delete' do #DELETE
  Transaction.delete(params[:id])
  redirect to("/transactions")
end

get '/transactions/:id/edit' do #EDIT
  @transaction = Transaction.find(params[:id])
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/edit")
end

put '/transactions/:id' do #UPDATE
  Transaction.new(params).update
  redirect to "/transactions"
end

get '/transactions/:id' do #SHOW
  transaction_id = params[:id]
  @transaction = Transaction.find(transaction_id)
  erb(:"transactions/show")
end

get '/transactions/by_tag/:id' do #TRANSACTIONS BY TAG
  @transaction_result = Transaction.by_tag(params[:id])
  erb(:"transactions/by_tag")
end
