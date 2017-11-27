require_relative('../db/sql_runner.rb')
require_relative('merchant.rb')
require_relative('tag.rb')

class Transaction

  attr_reader :id, :amount, :merchant_id, :tag_id

  def initialize(options)
    @id = options['id'].to_i
    @amount = options['amount']
    @merchant_id = options['merchant_id']
    @tag_id = options['tag_id']
  end

  def save
    sql = "INSERT INTO transactions(
      amount,
      merchant_id,
      tag_id
    )
    VALUES(
      $1, $2, $3
    )
      RETURNING *"
    values = [@amount, @merchant_id, @tag_id]
    transaction_data = SqlRunner.run(sql, values)
    @id = transaction_data[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM transactions"
    values = []
    transaction_data = SqlRunner.run(sql, values)
    result = transaction_data.map {|transaction| Transaction.new(transaction)}
    return result
  end

  def merchant
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [@merchant_id]
    results = SqlRunner.run(sql, values)
    final_result = Merchant.new(results[0])
    return final_result
  end

  def tag
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [@tag_id]
    results = SqlRunner.run(sql, values)
    final_result = Tag.new(results[0])
    return final_result
  end

  def self.delete(id)
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

end
