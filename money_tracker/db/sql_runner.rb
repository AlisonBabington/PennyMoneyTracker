require('pg')

class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({ dbname: 'd7vmdha24p2r8d', host: 'ec2-54-225-68-133.compute-1.amazonaws.com' })
      port: 5432, user: 'khgqxpfnhieonp', password: '241090e371da1cb7b0760d6796624b23a55fac104280ae1124d49bc48d3cedb8'})
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
