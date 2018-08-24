require_relative( '../db/sql_runner' )

class Merchant

  attr_accessor :id, :name

  def initialize(details)
    @id = details['id'].to_i if details['id'].to_i
    @name = details['name']
  end

  def save()
    sql = "INSERT INTO merchants
    (name) VALUES ($1)
    RETURNING id "
    values = [@name]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE merchants
    SET name = $1
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
   sql = "DELETE FROM merchants
   WHERE id = $1"
   values = [@id]
   SqlRunner.run(sql, values)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM merchants
    WHERE name = $1"
    values = [name]
    found_merchant = SqlRunner.run(sql, values)
    result = Merchant.map_merchant(found_merchant)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [id]
    found_merchant = SqlRunner.run(sql, values)
    result = Merchant.map_merchant(found_merchant)
  end

  def self.map_merchant(merchant_info)
   result = merchant_info.map {|merchant| Merchant.new(merchant)}
   return result
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    merchants = SqlRunner.run(sql)
    result = Merchant.map_merchant(merchants)
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

end
