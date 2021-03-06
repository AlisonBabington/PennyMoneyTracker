require_relative( '../db/sql_runner' )

class Tag

attr_accessor :id
attr_accessor :name

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
  end

  def save()
    sql= "INSERT INTO tags
    (name) VALUES ($1)
    RETURNING id "
    values = [@name]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE tags
    SET name = $1
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def find_transactions()
    sql = "SELECT transactions.* FROM transactions
    INNER JOIN tags
    ON tags.id = transactions.tag_id
    WHERE transactions.tag_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return Transaction.map_transactions(results)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM tags
    WHERE name = $1"
    values = [name]
    found_tag = SqlRunner.run(sql,values)
    return Tag.new(found_tag.first)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [id]
    found_tag = SqlRunner.run(sql,values)
    return Tag.new(found_tag.first)
  end

  def self.map_tags(tag_info)
   result = tag_info.map {|tag| Tag.new(tag)}
   return result
  end

  def self.all()
    sql = "SELECT * FROM tags"
    tag_info = SqlRunner.run(sql)
    result = Tag.map_tags(tag_info)
  end

  def self.delete_all()
    sql = "DELETE FROM tags"
    SqlRunner.run(sql)
  end

end
