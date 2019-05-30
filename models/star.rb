require_relative("../db/sql_runner.rb")
class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO stars (
    first_name,
    last_name
    ) VALUES (
      $1,$2
      ) RETURNING id"
      values = [@first_name, @last_name]
      star = SqlRunner.run( sql, values ).first
      @id = star["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM stars"
    stars = SqlRunner.run( sql )
    result = stars.map { |star| Star.new( star )}
    return result
  end

  def update()
    sql = "UPDATE stars SET (
    first_name,
    last_name
    ) =
    (
      $1, $2
      )
      WHERE id = $3"
      values = [@first_name, @last_name, @id]
      SqlRunner.run( sql, values )
  end


end
