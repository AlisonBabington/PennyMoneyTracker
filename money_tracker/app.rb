require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('controllers/transaction_controller')
require_relative('controllers/account_controller')
require_relative('controllers/merchant_controller')
require_relative('controllers/tag_controller')

require_relative('./models/transaction')
require_relative('./models/account')
require_relative('./models/merchant')
require_relative('./models/tag')
also_reload( './models/*' )

get '/' do
  erb( :index )
end
