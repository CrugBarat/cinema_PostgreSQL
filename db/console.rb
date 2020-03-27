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
                          'funds' => 25.00,
                          'fav_genre' => 'Crime'})

customer2 = Customer.new({'first_name' => 'Jean',
                          'last_name' => 'Grey',
                          'funds' => 35.25,
                          'fav_genre' => 'Animation'})

customer1.save()
customer2.save()


##################################################################
# SCREENS

screen1 = Screen.new({'name' => 'Screen 1',
                      'capacity' => 25})

screen1.save()


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
                         'screen_id' => screen1.id()})

film1.save()
film2.save()


##################################################################
# TICKETS

ticket1 = Ticket.new({'customer_id' => customer1.id,
                          'film_id' => film1.id()})

ticket2 = Ticket.new({'customer_id' => customer2.id,
                          'film_id' => film1.id()})

ticket3 = Ticket.new({'customer_id' => customer2.id,
                           'film_id' => film2.id()})

ticket4 = Ticket.new({'customer_id' => customer1.id,
                           'film_id' => film2.id()})

ticket1.save()
ticket2.save()
ticket3.save()
ticket4.save()


##################################################################
# SCREENINGS

screening1 = Screening.new({'start_time' => '21:00:00',
                            'end_time' => '00:30:00',
                            'film_id' => film1.id()})

screening2 = Screening.new({'start_time' => '01:00:00',
                            'end_time' => '03:30:00',
                            'film_id' => film1.id()})

screening3 = Screening.new({'start_time' => '12:00:00',
                            'end_time' => '14:00:00',
                            'film_id' => film2.id()})

screening4 = Screening.new({'start_time' => '14:30:00',
                            'end_time' => '16:30:00',
                            'film_id' => film2.id()})

screening1.save()
screening2.save()
screening3.save()
screening4.save()

##################################################################
# PRY

binding.pry
nil
