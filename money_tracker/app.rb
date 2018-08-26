require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('./models/account')
require_relative('./models/merchant')
also_reload( './models/*' )
require_relative('controllers/account_controller')
require_relative('controllers/merchant_controller')
# require_relative('controllers/transaction_controller')
# require_relative('controllers/tag_controller')

get '/' do
  erb( :index )
end
