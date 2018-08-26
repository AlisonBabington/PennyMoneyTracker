require('sinatra')
require('sinatra/contrib/all')

get '/merchants' do # index
  @merchants = Merchant.all()
  erb( :"merchants/index" )
end
