require('sinatra')
require('sinatra/contrib/all') if development?

get '/merchants' do # index
  @merchants = Merchant.all()
  erb( :"merchants/index" )
end

get '/merchants/:id' do # show
  @merchant = Merchant.find_by_id(params[:id])
  erb( :"merchants/show" )
end

post '/merchants' do # create
  @merchant = Merchant.new(params)
  @merchant.save()
  redirect back
end

get '/merchants/:id/edit' do #edit
  @merchant = Merchant.find_by_id(params[:id])
  erb(:"merchants/edit")
end

post '/merchants/:id' do #update
  merchant = Merchant.new(params)
  merchant.update()
  redirect to "/merchants/#{merchant.id}"
end

post "/merchants/:id/delete" do #delete
  merchant = Merchant.find_by_id(params[:id])
  merchant.delete()
  redirect to "/merchants"
end
