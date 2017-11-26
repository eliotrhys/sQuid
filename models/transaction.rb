require_relative('../db/sql_runner.rb')

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

end
