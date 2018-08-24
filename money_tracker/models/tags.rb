require_relative( '../db/sql_runner' )

class Tag

attr_accessor :id, :name

  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
  end

end
