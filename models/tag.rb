require_relative('../db/sql_runner.rb')

class Tag

  attr_reader :id, :tag

  def initialize(options)
    @id = options['id'].to_i
    @tag = options['tag']
  end

  def save
    sql = "INSERT INTO tags(
      tag
    )
    VALUES(
      $1
    )
      RETURNING *"
    values = [@tag]
    tag_data = SqlRunner.run(sql, values)
    @id = tag_data[0]['id'].to_i
  end

end
