require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('../models/merchant')

get '/transactions' do # index
  @transactions = Transaction.all()
  erb( :"transactions/index" )
end

get '/transactions/:id' do # show
  @transaction = Transaction.find_by_id(params[:id])
  erb( :"transactions/show" )
end

post '/transactions' do # create
  transaction = Transaction.new(params)
  transaction.save()
  redirect to "/users"
end


get '/transactions/:id/edit' do #edit
  @transaction = Transaction.find_by_id(params[:id])
  erb(:"transactions/edit")
end

post '/transactions/:id' do #update
  transaction = Transaction.new(params)
  transaction.update()
  redirect tp "/transactions/#{transaction.id}"
end

post "/transactions/:id/delete" do #delete
  transaction = Transaction.find_by_id(params[:id])
  transaction.delete()
  redirect to "/transactions"
end
