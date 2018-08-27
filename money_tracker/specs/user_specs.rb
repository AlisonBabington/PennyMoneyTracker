require('minitest/autorun')
require('minitest/rg')
require_relative('../models/user.rb')

class UserTest < Minitest::Test

  def setup()
    @user1 = User.new({"name" => "Current", "monthly_budget" => "1456.20"})
  end

  def test_user_has_name()
    assert_equal("Current", @user1.name)
  end

  def test_user_has_monthly_budget()
    assert_equal(1456.20, @user1.monthly_budget)
  end

  def test_monthly_budget_changes__positive()
    @user1.update_monthly_budget(40.00)
    assert_equal(1496.20, @user1.monthly_budget)
  end

  def test_monthly_budget_changes__negative()
    @user1.update_monthly_budget(-40.00)
    assert_equal(1416.20, @user1.monthly_budget)
  end
end
