require_relative('../db/sql_runner')

class Transaction

  attr_reader :id
  attr_accessor :description, :merchant_id, :tag_id, :user_id, :amount

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @amount = details['amount'].to_f.round(2)
    @description = details['description']
    @merchant_id = details['merchant_id'].to_i if details['merchant_id']
    @tag_id = details['tag_id'].to_i if details ['tag_id']
    @user_id = details['user_id'] if details ['tag_id']
  end

  def save()
    sql = "INSERT INTO transactions
    (amount, description, merchant_id, tag_id, user_id)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id "
    values = [@amount, @description, @merchant_id, @tag_id, @user_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
    SET (amount, description, merchant_id, tag_id, user_id) =
    ($1, $2, $3, $4, $5)
    WHERE id = $6"
    values = [@amount, @description, @merchant_id, @tag_id, @user_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
   sql = "DELETE FROM transactions
   WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
  end

  def reduce_balance()
    sql = " BEGIN;
    SELECT amount from transactions
    INNER JOIN on users
    WHERE user.id = transactions.user_id
    WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first.to_s
  end

  def get_transaction_amount()
    sql = "SELECT amount FROM transactions
    WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first.to_f
    p result
  end

  # def reduce_balance(user)
  #   sql = "UPDATE users
  #   SET (balance) = (balance - transaction.amount)
  #   INNER JOIN transactions
  #   ON transactions.user_id = user.ids
  #   WHERE id = $1"
  #   values = [@id]
  #   SqlRunner.run(sql, values)
  # end

  #reduce_balance
  #join users and transactions
  #reduce balance by transaction amount
  #update balance to this amount#


  def self.find_by_name(name)
    sql = "SELECT * FROM transactions
    WHERE name = $1"
    values = [name]
    found_transaction = SqlRunner.run(sql, values)
    result = Transaction.map_transactions(found_transaction)
  end

  def self.totals
   transactions = Transaction.all
   amount = transactions.map { |transaction| transaction.amount }
   amount.reduce(:+)
 end

 def self.merchants(merchant)
   sql = "SELECT transactions.* FROM transactions
   INNER JOIN merchants
   ON merchants.id = transactions.merchant_id
   WHERE merchants.id = $1"
   values = [@merchant_id]
   found_transaction = SqlRunner.run(sql, values)
   result = Transaction.map_transactions(found_transaction)
 end

  def self.find_by_id(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    found_transaction = SqlRunner.run(sql, values)
    return Transaction.new(found_transaction.first)
  end

  def self.map_transactions(transaction_info)
   result = transaction_info.map {|transaction| Transaction.new(transaction)}
   return result
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    transactions = SqlRunner.run(sql)
    result = Transaction.map_transactions(transactions)
  end

  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

end
