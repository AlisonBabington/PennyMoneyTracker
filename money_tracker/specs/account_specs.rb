require('minitest/autorun')
require('minitest/rg')
require_relative('../models/accounts.rb')

class AccountTest < Minitest::Test

  def setup()
    @account1 = Account.new({"name" => "Current", "balance" => "1456.20"})
  end

  def test_account_has_name()
    assert_equal("Current", @account1.name)
  end

  def test_account_has_balance()
    assert_equal(1456.20, @account1.balance)
  end
end
