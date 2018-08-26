require_relative('../db/sql_runner')

class Account

  attr_reader :id
  attr_accessor :name, :owner_first_name, :owner_last_name, :balance

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @owner_first_name = details['owner_first_name']
    @owner_last_name = details['owner_last_name']
    @balance = details['balance'].to_f.round(2)
  end

  def save()
    sql = "INSERT INTO accounts
    (name, owner_first_name, owner_last_name, balance)
    VALUES ($1, $2, $3, $4)
    RETURNING id "
    values = [@name, @owner_first_name, @owner_last_name, @balance]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE accounts
    SET (name, balance) =
    ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@name,@owner_first_name, @owner_last_name, @balance, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
   sql = "DELETE FROM accounts
   WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
  end

  def pretty_name()
    @owner_first_name + @owner_last_name
  end

  def reduce_balance(transaction)
    sql = "SELECT transaction.amount from transactions
    INNER JOIN transactions
    ON transactions.account_id = account.id
    WHERE transactions.account_id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
 
  def self.find_by_name(name)
    sql = "SELECT * FROM accounts
    WHERE name = $1"
    values = [name]
    found_account = SqlRunner.run(sql, values)
    return Account.new(found_account.first)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM accounts
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)

    return Account.new(results.first)
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
