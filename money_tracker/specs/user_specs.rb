require('minitest/autorun')
require('minitest/rg')
require_relative('../models/user.rb')

class UserTest < Minitest::Test

  def setup()
    @user1 = User.new({"name" => "Current", "balance" => "1456.20"})
  end

  def test_user_has_name()
    assert_equal("Current", @user1.name)
  end

  def test_user_has_balance()
    assert_equal(1456.20, @user1.balance)
  end

  def test_balance_changes__positive()
    @user1.update_balance(40.00)
    assert_equal(1496.20, @user1.balance)
  end

  def test_balance_changes__negative()
    @user1.update_balance(-40.00)
    assert_equal(1416.20, @user1.balance)
  end
end
