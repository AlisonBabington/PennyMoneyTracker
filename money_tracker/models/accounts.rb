require_relative('../db/sql_runner')

class Account

  attr_accessor :id, :name, :balance

  def initialize(details)
    @id = details['id'].to_i if details['id'].to_i
    @name = details['name']
    @balance = details['balance'].to_f.round(2)
  end

end
