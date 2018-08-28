require('minitest/autorun')
require('minitest/rg')
require_relative('../models/user.rb')

class UserTest < Minitest::Test

  def setup()
    @user1 = User.new({"owner_first_name" => "Laura", "weekly_budget" => "1456.20", "current_budget" => "100"})
  end

  def test_user_has_first_name()
    assert_equal("Laura", @user1.owner_first_name)
  end

  def test_user_has_weekly_budget()
    assert_equal(1456.20, @user1.weekly_budget)
  end

  def test_weekly_budget_changes__positive()
    @user1.update_weekly_budget(40.00)
    assert_equal(1496.20, @user1.weekly_budget)
  end

  def test_weekly_budget_changes__negative()
    @user1.update_weekly_budget(-40.00)
    assert_equal(1416.20, @user1.weekly_budget)
  end

  def test_budget_is_reaching_limit
    actual = "Careful! You are reaching the top of your weekly budget!"
    expected = @user1.budget_is_reaching_limit
    assert_equal(actual,expected)
  end
end
