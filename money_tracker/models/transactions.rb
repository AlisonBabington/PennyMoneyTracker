require_relative('../db/sql_runner')

class Transaction

  attr_reader :id
  attr_accessor :description, :merchant_id, :tag_id, :amount

  def initialize(details)
    @id = details['id'].to_i if details['id'].to_i
    @description = details['description']
    @merchant_id = details['merchant_id'].to_i if details['merchant_id'].to_i
    @tag_id = details['tag_id'].to_i if details ['tag_id'].to_i
    @amount = details['amount'].to_f.round(2)
  end

  def save()
    sql = "INSERT INTO transactions
    (description, merchant_id, tag_id, amount)
    VALUES ($1, $2, $3, $4)
    RETURNING id "
    values = [@description, @merchant_id, @tag_id, @amount]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
    SET description, merchant_id, tag_id, amount) =
    ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@description, @merchant_id, @tag_id, @amount, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
   sql = "DELETE FROM transactions
   WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM transactions
    WHERE name = $1"
    values = [name]
    found_transaction = SqlRunner.run(sql, values)
    result = Transaction.map_transactions(found_transaction)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    found_merchant = SqlRunner.run(sql, values)
    result = Transaction.map_transactions(found_transaction)
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
