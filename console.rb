require_relative("models/customers.rb")
require_relative("models/tickets.rb")
require_relative("models/films.rb")

require('pry-byebug')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({'name' => 'Jussi', 'funds' => '20'})
customer1.save()

film1 = Film.new({'title' => 'Black Panther', 'price' => '5'})
film1.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

binding.pry
nil
