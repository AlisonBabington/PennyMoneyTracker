require_relative('../db/sql_runner')

class User

  attr_reader :id
  attr_accessor :name, :owner_first_name, :owner_last_name, :monthly_budget

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @owner_first_name = details['owner_first_name']
    @owner_last_name = details['owner_last_name']
    @monthly_budget = details['monthly_budget'].to_f
  end

  def save()
    sql = "INSERT INTO users
    (name, owner_first_name, owner_last_name, monthly_budget)
    VALUES ($1, $2, $3, $4)
    RETURNING id "
    values = [@name, @owner_first_name, @owner_last_name, @monthly_budget]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE users
    SET (name, monthly_budget) =
    ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@name,@owner_first_name, @owner_last_name, @monthly_budget, @id]
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
  end

  def reduce_balance(transaction)
    update_monthly_budget(-transaction.amount)
    sql = "UPDATE users
    SET monthly_budget = $1
    WHERE id = $1"
    values = [@monthly_budget]
    SqlRunner.run(sql, values)
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
