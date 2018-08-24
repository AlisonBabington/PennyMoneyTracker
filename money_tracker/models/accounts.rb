require_relative('../db/sql_runner')

class Account

  attr_reader :id
  attr_accessor :name, :balance

  def initialize(details)
    @id = details['id'].to_i if details['id'].to_i
    @name = details['name']
    @balance = details['balance'].to_f.round(2)
  end

  def save()
    sql = "INSERT INTO accounts
    (name, balance) VALUES ($1, $2)
    RETURNING id "
    values = [@name, @balance]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE accounts
    SET (name, balance) =
    ($1, $2)
    WHERE id = $3"
    values = [@name, @balance, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
   sql = "DELETE FROM accounts
   WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM accounts
    WHERE name = $1"
    values = [name]
    found_account = SqlRunner.run(sql, values)
    result = Account.map_accounts(found_account)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM accounts
    WHERE id = $1"
    values = [id]
    found_merchant = SqlRunner.run(sql, values)
    result = Account.map_accounts(found_account)
  end

  def self.map_accounts(account_info)
   result = account_info.map {|account| Account.new(account)}
   return result
  end

  def self.all()
    sql = "SELECT * FROM accounts"
    accounts = SqlRunner.run(sql)
    result = Account.map_accounts(accounts)
  end

  def self.delete_all()
    sql = "DELETE FROM accounts"
    SqlRunner.run(sql)
  end

end
