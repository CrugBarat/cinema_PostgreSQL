require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :genre, :price, :rating

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @price = options['price']
    @rating = options['rating']
  end

  def save()
    sql = "INSERT INTO films
           (title, genre, price, rating)
           VALUES ($1, $2, $3, $4)
           RETURNING *"
    values = [@title, @genre, @price, @rating]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def update()
    sql = "UPDATE films SET
           (title, genre, price, rating)
           = ($1, $2, $3, $4)
           WHERE id = $5"
    values = [@title, @genre, @price, @rating, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    self.returning_single_film(results)
  end

  def self.find_by_title(title)
    sql = "SELECT * FROM films
           WHERE title = $1"
    values = [title]
    results = SqlRunner.run(sql, values)
    self.returning_single_film(results)
  end

  def self.find_by_genre(genre)
    sql = "SELECT * FROM films
           WHERE genre = $1"
    values = [genre]
    results = SqlRunner.run(sql, values)
    self.map_items(results)
  end

  def self.find_by_price_range(price1, price2)
    sql = "SELECT * FROM films
           WHERE price >= $1 AND price <= $2"
    values = [price1, price2]
    results = SqlRunner.run(sql, values)
    self.map_items(results)
  end

  def self.all_alphabetical_by_title()
    sql = "SELECT * FROM films
           ORDER BY title"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def customers()
    sql = "SELECT customers.*
           FROM customers
           INNER JOIN tickets
           ON tickets.customer_id = customers.id
           INNER JOIN screenings
           ON tickets.screening_id = screenings.id
           WHERE screenings.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Customer.map_items(result)
  end

  def screens()
    sql = "SELECT screens.*
           FROM screens
           INNER JOIN screenings
           ON screenings.screen_id = screens.id
           INNER JOIN films
           ON screenings.film_id = films.id
           WHERE films.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Screen.map_items(result)
  end

  def screenings()
    sql = "SELECT * FROM screenings
           WHERE film_id = $1 "
    values =[@id]
    result = SqlRunner.run(sql, values)
    Screening.map_items(result)
  end

  def tickets()
    sql = "SELECT tickets.*
           FROM tickets
           INNER JOIN screenings
           ON tickets.screening_id = screenings.id
           INNER JOIN films
           ON screenings.film_id = films.id
           WHERE films.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Ticket.map_items(result)
  end

  def number_of_tickets()
    tickets().size()
  end

  def self.create_a_film(title, genre, price, rating)
    sql = "INSERT INTO films
           (title, genre, price, rating)
           VALUES ($1, $2, $3, $4)
           RETURNING *"
    values = [title, genre, price, rating]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.map_items(result)
    result.map{|film| Film.new(film)}
  end

  def self.returning_single_film(results)
    return nil if results.first() == nil
    Film.new(results.first())
  end

end
