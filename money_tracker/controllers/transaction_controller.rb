require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/merchant')
require_relative('../models/user')

get '/transactions' do # index
  @transactions = Transaction.all()
  erb( :"transactions/index" )
end

get '/transactions/month' do
  @transactions = Transaction.filter_by_month(params[:month], params[:year])
  erb (:"transactions/filter")
end

get '/transactions/tag' do
  @transactions = Transaction.tags(params[:tag_id])
  erb (:"transactions/filter")
end

get '/transactions/merchant' do
  @transactions = Transaction.merchants(params[:merchant_id])
  erb (:"transactions/filter")
end

get '/transactions/:id' do # show
  @transaction = Transaction.find_by_id(params[:id])
  erb( :"transactions/show" )
end

post '/transactions' do # create
  transaction = Transaction.new(params)
  transaction.convert_currency()
  transaction.save()
  transaction_user = User.find_by_id(transaction.user_id)
  transaction_user.update_current_budget(transaction)
  redirect back
end


get '/transactions/:id/edit' do #edit
  @transaction = Transaction.find_by_id(params[:id])
  erb(:"transactions/edit")
end

post '/transactions/:id' do #update
  transaction = Transaction.new(params)
  transaction.update()
  redirect to "/transactions/#{transaction.id}"
end

post "/transactions/:id/delete" do #delete
  @transaction = Transaction.find_by_id(params[:id])
  @transaction_user = User.find_by_id(@transaction.user_id)
  erb(:"transactions/delete")
  sleep 1.1
  redirect to "/users/#{@transaction_user.id}"
end
