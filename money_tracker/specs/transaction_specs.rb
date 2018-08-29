require('minitest/autorun')
require('minitest/rg')
require_relative('../models/transaction.rb')

class TransactionTest < MiniTest::Test

  def setup()
    @transaction1 = Transaction.new({"amount" => 24.50, "description" => "2 x Cinema Tickets and Popcorn",
      "time_stamp" => "2018-06-25 20:02:00" })

    @transaction2 = Transaction.new({"amount" => 15.00, "description" => "Round of Drinks",
      "time_stamp" => "2018-08-25 22:32:05"})

    @transactions = Transaction.all()

  end

  def test_transaction_has_description()
    assert_equal("2 x Cinema Tickets and Popcorn", @transaction1.description)
  end

  def test_transaction_has_amount()
    assert_equal(15.00, @transaction2.amount)
  end

  def test_transaction_filter_by_month()
    results = Transaction.filter_by__month("08", "2018")
    assert_equal(@transaction2.description, results)
  end

end
