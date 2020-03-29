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
                          'funds' => 50.50,
                          'fav_genre' => 'Crime',
                          'age' => 60})

customer2 = Customer.new({'first_name' => 'Jean',
                          'last_name' => 'Grey',
                          'funds' => 25.25,
                          'fav_genre' => 'Animation',
                          'age' => 14})

customer3 = Customer.new({'first_name' => 'Scott',
                          'last_name' => 'Summers',
                          'funds' => 5.50,
                          'fav_genre' => 'Sci-Fi',
                          'age' => 21})

customer4 = Customer.new({'first_name' => 'Ororo',
                          'last_name' => 'Munroe',
                          'funds' => 43.75,
                          'fav_genre' => 'Fantasy',
                          'age' => 33})

customer1.save()
customer2.save()
customer3.save()
customer4.save()


##################################################################
# SCREENS

screen1 = Screen.new({'name' => 'Screen 1',
                      'capacity' => 25})

screen2 = Screen.new({'name' => 'Screen 2',
                      'capacity' => 5})

screen3 = Screen.new({'name' => 'Screen 2',
                      'capacity' => 50})

screen1.save()
screen2.save()
screen3.save()


##################################################################
#FILMS

# Film Ratings Key(U = 0, PG = 10, 12 = 12, 15 = 15, 18 = 18)

film1 = Film.new({'title' => 'Pulp Fiction',
                  'genre' => 'Crime',
                  'price' => 6.50,
                  'rating' => 15})

film2 = Film.new({'title' => 'Monsters Inc',
                  'genre' => 'Animation',
                  'price' => 8.95,
                  'rating' => 0})

film3 = Film.new({'title' => 'The Conjuring',
                  'genre' => 'Horror',
                  'price' => 7.50,
                  'rating' => 18})

film4 = Film.new({'title' => 'Frozen 2',
                  'genre' => 'Animation',
                  'price' => 11.95,
                  'rating' => 0})

film1.save()
film2.save()
film3.save()
film4.save()


##################################################################
# SCREENINGS

screening1 = Screening.new({'start_time' => '21:00:00',
                            'end_time' => '00:30:00',
                            'film_id' => film1.id,
                            'number_of_tickets' => 0,
                            'screen_id' => screen1.id()})

screening2 = Screening.new({'start_time' => '01:00:00',
                            'end_time' => '03:30:00',
                            'film_id' => film1.id,
                            'number_of_tickets' => 0,
                            'screen_id' => screen1.id()})

screening3 = Screening.new({'start_time' => '12:00:00',
                            'end_time' => '14:00:00',
                            'film_id' => film2.id,
                            'number_of_tickets' => 0,
                            'screen_id' => screen2.id()})

screening4 = Screening.new({'start_time' => '14:30:00',
                            'end_time' => '16:30:00',
                            'film_id' => film2.id,
                            'number_of_tickets' => 0,
                            'screen_id' => screen2.id()})

screening5 = Screening.new({'start_time' => '20:00:00',
                            'end_time' => '22:15:00',
                            'film_id' => film3.id,
                            'number_of_tickets' => 0,
                            'screen_id' => screen3.id()})

screening6 = Screening.new({'start_time' => '22:45:00',
                            'end_time' => '01:00:00',
                            'film_id' => film3.id,
                            'number_of_tickets' => 0,
                            'screen_id' => screen3.id()})

screening7 = Screening.new({'start_time' => '13:00:00',
                            'end_time' => '15:00:00',
                            'film_id' => film4.id,
                            'number_of_tickets' => 0,
                            'screen_id' => screen3.id()})

screening8 = Screening.new({'start_time' => '15:30:00',
                            'end_time' => '17:30:00',
                            'film_id' => film4.id,
                            'number_of_tickets' => 0,
                            'screen_id' => screen3.id()})

screening1.save()
screening2.save()
screening3.save()
screening4.save()
screening5.save()
screening6.save()
screening7.save()
screening8.save()


##################################################################
# TICKETS

ticket1 = Ticket.new({'customer_id' => customer1.id,
                      'screening_id' => screening1.id()})

ticket2 = Ticket.new({'customer_id' => customer1.id,
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
# UPDATES TO EXISTING DATA

customer1.update_funds()
customer2.update_funds()
screening1.update_tickets_sold()
screening2.update_tickets_sold()
screening3.update_tickets_sold()
screening4.update_tickets_sold()


##################################################################
# PRY

binding.pry
nil

##################################################################
