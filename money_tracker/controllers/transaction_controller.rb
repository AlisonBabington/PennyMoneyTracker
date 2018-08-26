require( 'sinatra' )
require( 'sinatra/contrib/all' )

get '/transactions' do # index
  @transactions = Transaction.all()
  erb( :"transactions/index" )
end
