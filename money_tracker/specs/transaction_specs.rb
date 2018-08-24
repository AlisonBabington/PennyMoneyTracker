require('minitest/autorun')
require('minitest/rg')
require_relative('../models/transactions.rb')

class TransactionTest < MiniTest::Test

  def setup()
    @transaction1 = Transaction.new(
      {"description" => "weekly shop", "amount" => "49.56"}
    )
  end

  def test_transaction_has_description()
    assert_equal("weekly shop", @transaction1.description)
  end

  def test_transaction_has_amount()
    assert_equal(49.56, @transaction1.amount)
  end

end
