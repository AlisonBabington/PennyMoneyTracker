require('minitest/autorun')
require('minitest/rg')
require_relative('../models/merchants.rb')

class MerchantTest < MiniTest::Test

  def test_merchant_has_name()
  merchant1 = Merchant.new({"name" => "Waitrose"})
  assert_equal("Waitrose", merchant1.name)
  end

end
