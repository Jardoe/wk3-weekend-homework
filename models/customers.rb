require_relative("../db/sql_runner.rb")

class Customer
  attr_reader :funds
  attr_accessor :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
      (
        name,
        funds
      )
      VALUES
      (
        $1,$2
      )
      RETURNING id"
      values = [@name, @funds]
      customer = SqlRunner.run(sql, values).first()
      @id = customer['id'].to_i
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)

  end
end
