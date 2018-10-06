require( 'sinatra' )
require( 'sinatra/contrib/all' )


get '/users' do # index
  @users = User.all()
  erb( :"users/index" )
end


get '/users/:id' do # show
  @user = User.find_by_id(params[:id])
  erb( :"users/show" )
end

post '/users' do # create
  @user = User.new(params)
  @user.save()
  redirect to '/users'
end

get '/users/:id/edit' do #edit
  @user = User.find_by_id(params[:id])
  erb(:"users/edit")
end

get '/users/:id/new_week' do
  @user = User.find_by_id(params[:id])
  erb(:"users/new_week")
end

post '/users/:id' do #update
  user = User.new(params)
  user.update()
  redirect to "/users/#{user.id}"
end

post "/users/:id/delete" do #delete
  user = User.find_by_id(params[:id])
  user.delete()
  redirect to "/users"
end
