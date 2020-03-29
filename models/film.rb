require_relative('../db/sql_runner.rb')

class Film

  attr_reader :id
  attr_accessor :title, :genre, :price, :rating, :screen_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @price = options['price']
    @rating = options['rating']
    @screen_id = options['screen_id'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, genre, price, rating, screen_id)
           VALUES ($1, $2, $3, $4, $5)
           RETURNING *"
    values = [@title, @genre, @price, @rating, @screen_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def update()
    sql = "UPDATE films SET (title, genre, price, rating, screen_id)
           = ($1, $2, $3, $4, $5)
           WHERE id = $6"
    values = [@title, @genre, @price, @rating, @screen_id, @id]
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

  def screenings()
    sql = "SELECT * FROM screenings
           WHERE film_id = $1 "
    values =[@id]
    result = SqlRunner.run(sql, values)
    Screening.map_items(result)
  end

  def number_of_customers()
    customers().size()
  end

  def self.map_items(result)
    result.map{|film| Film.new(film)}
  end

  def self.returning_single_film(results)
    return nil if results.first() == nil
    return Film.new(results.first())
  end

end
