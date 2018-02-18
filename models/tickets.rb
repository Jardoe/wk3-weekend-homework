require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (customer_id, film_id)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first()
    @id = ticket['id'].to_i
  end

  def customer ()
    sql = "SELECT *
    FROM customers
    WHERE id = $1"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end

  def film ()
    sql = "SELECT * FROM films WHERE id =$1"
    values = [@film_id]
    return Film.new(SqlRunner.run(sql, values).first())
  end

    def Ticket.count_customers()
      sql = "
      SELECT films.title, COUNT(Tickets.id)
      AS NumberOfCustomers From tickets
      LEFT JOIN films ON Tickets.film_id = films.id
      GROUP BY title;"
      numbers = SqlRunner.run(sql)
      return numbers.values
    end

  def Ticket.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    return tickets.map { |ticket| Ticket.new(ticket)  }
  end


  def Ticket.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end
end
