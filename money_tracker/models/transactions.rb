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

end
