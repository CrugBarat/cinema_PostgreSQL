require('sinatra')
require('sinatra/contrib/all') if development?

require_relative('./models/app_data.rb')
require_relative('./models/customer.rb')
require_relative('./models/film.rb')
require_relative('./models/screening.rb')
require_relative('./models/ticket.rb')
require_relative('./models/screen.rb')
also_reload('./models/*')


get '/home' do
  @films_data = AppData.all()
  erb(:home)
end

get '/home/book' do
  @customers = Customer.all()
  @films = Film.all()
  @screenings = Screening.all()
  erb(:book)
end

#CREATE
post '/home' do
  customer_id = params['customer_id'].to_i
  screening_id = params['screening_id'].to_i
  film_id = params['film_id'].to_i
  new_ticket = Ticket.sell(customer_id, film_id, screening_id)
  @film1 = Film.find_by_id(film_id)
  @screening1 = Screening.find_by_id(screening_id)
  @customer1 = Customer.find_by_id(customer_id)
  erb(:success)
end
