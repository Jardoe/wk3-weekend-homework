require_relative('../db/sql_runner.rb')
class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (title, price)
    VALUES ($1, $2)
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first()
    @id = film['id'].to_i
  end

  def edit_name(new_name)
    sql = "UPDATE films
    SET title = $1
    WHERE id = $2
    RETURNING *;"
    values = [new_name, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "
    SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return customers.map { |customer| Customer.new(customer)}
  end




  def Film.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def Film.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    films.map { |film| Film.new(film) }
  end

  def Film.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    Film.new(SqlRunner.run(sql, values).first())
  end

end
