require_relative('../db/sql_runner')

class User

  attr_reader :id
  attr_accessor :owner_first_name, :owner_last_name, :monthly_budget, :current_budget

  def initialize(details)

    if details['current_budget'] == nil
      @current_budget = details['monthly_budget'].to_f
    else
      @current_budget = details['current_budget'].to_f
    end

    # @current_budget = details['current_budget'] == 0 ? details['monthly_budget'].to_f : details['current_budget'].to_f

    @id = details['id'].to_i if details['id']
    @owner_first_name = details['owner_first_name']
    @owner_last_name = details['owner_last_name']
    @monthly_budget = details['monthly_budget'].to_f
  end

  def save()
    sql = "INSERT INTO users
    (owner_first_name, owner_last_name, monthly_budget)
    VALUES ($1, $2, $3)
    RETURNING id "
    values = [@owner_first_name, @owner_last_name, @monthly_budget]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE users
    SET (owner_first_name, owner_last_name, monthly_budget) =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@owner_first_name, @owner_last_name, @monthly_budget, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
   sql = "DELETE FROM users
   WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
  end

  def pretty_name()
    "#{@owner_first_name} + #{@owner_last_name}"
  end

  def update_monthly_budget(amount)
    @monthly_budget += amount
    sql =  "UPDATE users
    SET monthly_budget = $1
    WHERE id = $2"
    values = [@monthly_budget, @id]
    SqlRunner.run(sql, values)
  end

  def update_current_budget(transaction)
    @current_budget -= (transaction.amount * 4)
    sql =  "UPDATE users
    SET current_budget = $1
    WHERE id = $2"
    values = [@current_budget, @id]
    SqlRunner.run(sql, values)
  end

  def update_current_budget_on_delete(transaction)
    @current_budget -= (transaction.amount * 4)
    sql =  "UPDATE users
    SET current_budget = $1
    WHERE id = $2"
    values = [@current_budget, @id]
    SqlRunner.run(sql, values)
  end

  def budget_is_reaching_limit
    return "Careful! You are reaching the top of your weekly budget!" if @current_budget <= 100
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM users
    WHERE name = $1"
    values = [name]
    found_user = SqlRunner.run(sql, values)
    return User.new(found_user.first)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM users
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return User.new(results.first)
  end

  def self.map_users(user_info)
   result = user_info.map {|user| User.new(user)}
   return result
  end

  def self.all()
    sql = "SELECT * FROM users"
    users = SqlRunner.run(sql)
    result = User.map_users(users)
  end

  def self.delete_all()
    sql = "DELETE FROM users"
    SqlRunner.run(sql)
  end


end
