require('pry-byebug')
require_relative('../models/customer.rb')
require_relative('../models/film.rb')
require_relative('../models/ticket.rb')
require_relative('../models/screening.rb')
require_relative('../models/screen.rb')

Ticket.delete_all()
Customer.delete_all()
Screening.delete_all()
Film.delete_all()
Screen.delete_all()

##################################################################
# CUSTOMERS

customer1 = Customer.new({'first_name' => 'Charles',
                          'last_name' => 'Xavier',
                          'funds' => 35.50,
                          'fav_genre' => 'Crime'})

customer2 = Customer.new({'first_name' => 'Jean',
                          'last_name' => 'Grey',
                          'funds' => 25.25,
                          'fav_genre' => 'Animation'})

customer1.save()
customer2.save()


##################################################################
# SCREENS

screen1 = Screen.new({'name' => 'Screen 1',
                      'capacity' => 25})

screen2 = Screen.new({'name' => 'Screen 2',
                      'capacity' => 4})

screen1.save()
screen2.save()


##################################################################
#FILMS

film1 = Film.new({'title' => 'Pulp Fiction',
                             'genre' => 'Crime',
                             'price' => 6.50,
                             'rating' => '15',
                             'screen_id' => screen1.id()})

film2 = Film.new({'title' => 'Monsters Inc',
                             'genre' => 'Animation',
                             'price' => 8.95,
                             'rating' => 'U',
                             'screen_id' => screen2.id()})

film1.save()
film2.save()


##################################################################
# SCREENINGS

screening1 = Screening.new({'start_time' => '21:00:00',
                            'end_time' => '00:30:00',
                            'film_id' => film1.id,
                            'number_of_tickets' => 0})

screening2 = Screening.new({'start_time' => '01:00:00',
                            'end_time' => '03:30:00',
                            'film_id' => film1.id,
                            'number_of_tickets' => 0})

screening3 = Screening.new({'start_time' => '12:00:00',
                            'end_time' => '14:00:00',
                            'film_id' => film2.id,
                            'number_of_tickets' => 0})

screening4 = Screening.new({'start_time' => '14:30:00',
                            'end_time' => '16:30:00',
                            'film_id' => film2.id,
                            'number_of_tickets' => 0})

screening1.save()
screening2.save()
screening3.save()
screening4.save()


##################################################################
# TICKETS

ticket1 = Ticket.new({'customer_id' => customer1.id,
                      'screening_id' => screening1.id()})

ticket2 = Ticket.new({'customer_id' => customer2.id,
                      'screening_id' => screening2.id()})

ticket3 = Ticket.new({'customer_id' => customer2.id,
                      'screening_id' => screening3.id()})

ticket4 = Ticket.new({'customer_id' => customer1.id,
                      'screening_id' => screening3.id()})

ticket5 = Ticket.new({'customer_id' => customer1.id,
                      'screening_id' => screening3.id()})

ticket6 = Ticket.new({'customer_id' => customer1.id,
                      'screening_id' => screening3.id()})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()
ticket5.save()
ticket6.save()


##################################################################
# UPDATES

customer1.update_funds()
customer2.update_funds()
screening1.update_number_of_tickets()
screening2.update_number_of_tickets()
screening3.update_number_of_tickets()
screening4.update_number_of_tickets()


##################################################################
# PRY

binding.pry
nil

##################################################################
