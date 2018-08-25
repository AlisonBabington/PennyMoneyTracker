require('minitest/autorun')
require('minitest/rg')
require_relative('../models/transactions.rb')

class TransactionTest < MiniTest::Test

  def setup()
    @transaction1 = Transaction.new(
      {"description" => "food shop", "amount" => "20.50"}
    )
    @transaction2 = Transaction.new({"description" => "cinema tickets",
      "amount" => "19.00"})

  end

  def test_transaction_has_description()
    assert_equal("food shop", @transaction1.description)
  end

  def test_transaction_has_amount()
    assert_equal(20.50, @transaction1.amount)
  end

  def test_transaction_totals()
    actual = Transaction.totals
    assert_equal(39.50, actual)
  end
end
