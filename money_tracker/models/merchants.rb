require_relative( '../db/sql_runner' )

class Merchant

  attr_accessor :id, :name

  def initialize(details)
    @id = details['id'].to_i if details['id'].to_i
    @name = details['name']
  end

  def save()
    sql = "INSERT INT0 merchants
    (name) VALUES ($1)
    RETURNING ID"
    values = [@name]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM merchants"
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

end
