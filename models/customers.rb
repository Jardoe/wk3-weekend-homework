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

  def films()
    sql = "
    SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return films.map { |film| Film.new(film)}
  end

  def film_number()
    sql = " SELECT COUNT(*) FROM tickets
    WHERE customer_id = $1;"
    values = [@customer_id]
    return SqlRunner.run(sql,values).first()
  end

  def Customer.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def Customer.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    customers.map { |customer| Customer.new(customer)  }
  end

  def Customer.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    Customer.new(SqlRunner.run(sql, values).first())
  end
end
