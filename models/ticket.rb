require_relative('../db/sql_runner.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
           (customer_id, screening_id)
           VALUES ($1, $2)
           RETURNING *"
    values = [@customer_id, @screening_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def update()
    sql = "UPDATE tickets
           SET (customer_id, screening_id)
           = ($1, $2)
           WHERE id = $3"
    values = [@customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    self.returning_single_ticket(results)
  end

  def self.find_by_customer_id(customer_id)
    sql = "SELECT * FROM tickets
           WHERE customer_id = $1"
    values = [customer_id]
    results = SqlRunner.run(sql, values)
    self.returning_single_ticket(results)
  end

  def screening()
    sql = "SELECT * FROM screenings
           WHERE id = $1"
    values = [@screening_id]
    result = SqlRunner.run(sql, values).first
    Screening.new(result)
  end

  def customer()
    sql = "SELECT * FROM customers
           WHERE id = $1"
    values = [@customer_id]
    result = SqlRunner.run(sql, values).first
    Customer.new(result)
  end

  def screen()
    sql = "SELECT screens.*
           FROM screens
           INNER JOIN screenings
           ON screenings.screen_id = screens.id
           INNER JOIN tickets
           ON tickets.screening_id = screenings.id
           WHERE tickets.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Screen.map_items(result).first()
  end

  def film()
    sql = "SELECT films.*
           FROM films
           INNER JOIN screenings
           ON screenings.film_id = films.id
           INNER JOIN tickets
           ON tickets.screening_id = screenings.id
           WHERE tickets.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Film.map_items(result).first()
  end

  def self.new_ticket(customer_id, screening_id)
    ticket = Ticket.new({'customer_id' => customer_id,
                         'screening_id' => screening_id})
    ticket.save()
  end

  def self.sell(customer_id, film_id, screening_id)
    customer = Customer.find_by_id(customer_id)
    film = Film.find_by_id(film_id)
    screening = Screening.find_by_id(screening_id)
    return if screening.over_capacity?()
    return if !customer.has_funds?(film)
    return if !customer.is_old_enough?(film)
    self.new_ticket(customer.id, screening.id)
    customer.pay(film)
    screening.update_new_tickets()
  end

  def self.sell_meerkat_tuesdays_bogof(customer, film, screening)
    return if screening.over_capacity?()
    return if !customer.has_funds?(film)
    return if !customer.is_old_enough?(film)
    self.new_ticket(customer.id, screening.id)
    self.new_ticket(customer.id, screening.id)
    customer.pay(film)
    screening.update_new_tickets()
    screening.update_new_tickets()
  end

  def self.sell_fav_genre_promotion(customer, film, screening)
    return if screening.over_capacity?()
    return if !customer.has_funds?(film)
    return if !customer.is_old_enough?(film)
    return if !customer.fav_genre_showing?()
    return if customer.fav_genre_equals_film_genre?(film)
    self.new_ticket(customer.id, screening.id)
    customer.pay_discount(film)
    screening.update_new_tickets()
  end

  def self.map_items(result)
    result.map{|ticket| Ticket.new(ticket)}
  end

  def self.returning_single_ticket(results)
    return nil if results.first() == nil
    Ticket.new(results.first())
  end

end
