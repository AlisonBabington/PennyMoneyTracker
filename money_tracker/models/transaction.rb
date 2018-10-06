require_relative('../db/sql_runner')

class Transaction

  attr_reader :id, :time_stamp
  attr_accessor :description, :merchant_id, :tag_id, :user_id,
   :amount, :currency, :gbp_amount

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @amount = details['amount'].to_f.round(2)
    @gbp_amount = details['gbp_amount'].to_f
    @description = details['description']
    @merchant_id = details['merchant_id'].to_i if details['merchant_id']
    @tag_id = details['tag_id'].to_i if details ['tag_id']
    @user_id = details['user_id'] if details ['user_id']
    @time_stamp = details['time_stamp'] ||  Time.now()
    @currency = details['currency']
  end

  def save()
    sql = "INSERT INTO transactions
    (amount, gbp_amount, description, merchant_id, tag_id, user_id, time_stamp, currency)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
    RETURNING id "
    values = [ @amount, @gbp_amount, @description, @merchant_id,
    @tag_id, @user_id, @time_stamp, @currency]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE transactions
    SET (currency, amount, gbp_amount, description, merchant_id, tag_id, user_id) =
    ($1, $2, $3, $4, $5, $6)
    WHERE id = $7"
    values = [@currency, @amount, @gbp_amount, @description, @merchant_id, @tag_id, @user_id, @id]
    SqlRunner.run(sql, values)
  end

  def update_currency()
    sql = "UPDATE transactions
    SET gbp_amount = $1
    WHERE id = $2"
    values = [@gbp_amount, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
   sql = "DELETE FROM transactions
   WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
  end

  def user()
    sql = "SELECT * FROM USERS
    WHERE id = $1"
    values = [@user_id]
    result = SqlRunner.run(sql, values)
  end

  def merchant()
    sql ="SELECT * FROM merchants
    WHERE id = $1"
    values = [@merchant_id]
    found_merchant = SqlRunner.run(sql,values)
    result = Merchant.new(found_merchant[0])
  end

  def tag()
    sql ="SELECT * FROM tags
    WHERE id = $1"
    values = [@tag_id]
    found_tag = SqlRunner.run(sql,values)
    result = Tag.new(found_tag[0])
  end

  def get_transaction_amount()
    sql = "SELECT amount FROM transactions
    WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first.to_f
    p result
  end

  def convert_usd()
    @gbp_amount = (@amount * 0.77)
  end

  def convert_eur()
    @gbp_amount = (@amount * 0.91)
  end

  def convert_jpy()
    @gbp_amount = (@amount * 0.0069)
  end

  def convert_currency()
    if @currency == "GBP"
      @gbp_amount = @amount
      return
    elsif @currency == "USD"
      convert_usd
      return
    elsif @currency == "EUR"
      convert_eur
      return
    elsif @currency == "JPY"
      convert_jpy
      return
    end
  end

  def self.filter_by_month(month, year)
    sql= "SELECT * FROM transactions
    WHERE EXTRACT(year from time_stamp) = $2
    and EXTRACT(month from time_stamp) = $1"
    values= [month, year]
    result = SqlRunner.run(sql, values)
    Transaction.map_transactions(result)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM transactions
    WHERE name = $1"
    values = [name]
    found_transaction = SqlRunner.run(sql, values)
    result = Transaction.map_transactions(found_transaction)
  end

  def self.totals
   transactions = Transaction.all
   amount = transactions.map { |transaction| transaction.gbp_amount }
   total = amount.reduce(:+)
   return if total == nil
   return total
 end

 def self.merchants(merchant_id)
   sql = "SELECT transactions.* FROM transactions
   INNER JOIN merchants
   ON merchants.id = transactions.merchant_id
   WHERE transactions.merchant_id = $1"
   values = [merchant_id]
   found_transaction = SqlRunner.run(sql, values)
   result = Transaction.map_transactions(found_transaction)
 end

 def self.tags(tag_id)
   sql = "SELECT transactions.* FROM transactions
   INNER JOIN tags
   ON tags.id = transactions.tag_id
   WHERE transactions.tag_id = $1"
   values = [tag_id]
   found_transaction = SqlRunner.run(sql, values)
   result = Transaction.map_transactions(found_transaction)
 end

  def self.find_by_id(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    found_transaction = SqlRunner.run(sql, values)
    result = Transaction.new(found_transaction.first)
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
