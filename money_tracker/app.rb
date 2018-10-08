require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require ('time')
require ('date')

require_relative('controllers/transaction_controller')
require_relative('controllers/user_controller')
require_relative('controllers/merchant_controller')
require_relative('controllers/tag_controller')

require_relative('./models/transaction')
require_relative('./models/user')
require_relative('./models/merchant')
require_relative('./models/tag')
also_reload( './models/*' )

get '/' do
  erb( :"users/index" )
end
