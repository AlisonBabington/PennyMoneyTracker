require( 'sinatra' )
require( 'sinatra/contrib/all' )


get '/accounts' do # index
  @accounts = Account.all()
  erb( :"accounts/index" )
end

get '/accounts/new' do # new
  erb( :"accounts/new ")
end

get '/accounts/:id' do # show
  @account = Account.find_by_id(params[:id])
  erb( :"accounts/show" )
end

post '/accounts' do # create
  @account = Account.new(params)
  @account.save()
  redirect to '/accounts'
end

get 'accounts/:id/edit' do #edit
  @account = Account.find_by_id(params[:id])
  erb(:"accounts/edit")
end

post '/accounts/:id' do #update
  account = Account.new(params)
  account.update()
  redirect tp "/accounts/#{account.id}"
end

post "/accounts/:id/delete" do #delete
  account = Account.find_by_id(params[:id])
  account.delete()
  redirect to "/accounts"
end
