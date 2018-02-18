require_relative("models/customers.rb")
require_relative("models/tickets.rb")
require_relative("models/films.rb")

require('pry-byebug')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

film1 = Film.new({'title' => 'Black Panther', 'price' => '5'})
film1.save()
film2 = Film.new({'title' => 'Superman', 'price' => '5'})
film2.save()
film3 = Film.new({'title' => 'Pulp Fiction', 'price' => '5'})
film3.save()

customer1 = Customer.new({'name' => 'Jussi', 'funds' => '20'})
customer1.save()
customer2 = Customer.new({'name' => 'Steve', 'funds' => '15'})
customer2.save()

ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket2.save()
ticket3 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3.save()

binding.pry
nil
