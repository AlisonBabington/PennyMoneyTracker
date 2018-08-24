require_relative( '../db/sql_runner' )

class Merchant

  attr_accessor :id, :name

  def initialize(details)
    @id = details['id'].to_i if details['id'].to_i
    @name = details['name']
  end

end
