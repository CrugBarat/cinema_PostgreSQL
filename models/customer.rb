require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :first_name, :last_name, :funds, :fav_genre, :age

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @funds = options['funds'].to_f
    @fav_genre = options['fav_genre']
    @age = options['age'].to_i
  end

  def save()
    sql = "INSERT INTO customers
           (first_name, last_name, funds, fav_genre, age)
           VALUES ($1, $2, $3, $4, $5)
           RETURNING *"
    values = [@first_name, @last_name, @funds, @fav_genre, @age]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def update()
    sql = "UPDATE customers
           SET (first_name, last_name, funds, fav_genre, age)
           = ($1, $2, $3, $4, $5)
           WHERE id = $6"
    values = [@first_name, @last_name, @funds, @fav_genre, @age, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    self.returning_single_customer(results)
  end

  def self.find_by_name(first_name, last_name)
    sql = "SELECT * FROM customers
           WHERE first_name = $1
           AND last_name = $2"
    values = [first_name, last_name]
    results = SqlRunner.run(sql, values)
    self.returning_single_customer(results)
  end

  def self.find_by_fav_genre(fav_genre)
    sql = "SELECT * FROM customers
           WHERE fav_genre = $1"
    values = [fav_genre]
    results = SqlRunner.run(sql, values)
    self.map_items(results)
  end

  def self.all_alphabetical_by_last_name()
    sql = "SELECT * FROM customers
           ORDER BY last_name"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def films()
    sql = "SELECT films.* FROM films
           INNER JOIN screenings
           ON screenings.film_id = films.id
           INNER JOIN tickets
           ON tickets.screening_id = screenings.id
           WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Film.map_items(result)
  end

  def screenings()
    sql = "SELECT screenings.* FROM screenings
           INNER JOIN tickets
           ON tickets.screening_id = screenings.id
           WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Screening.map_items(result)
  end

  def screens()
    sql = "SELECT screens.*
           FROM screens
           INNER JOIN screenings
           ON screenings.screen_id = screens.id
           INNER JOIN tickets
           ON tickets.screening_id = screenings.id
           WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Screen.map_items(result)
  end

  def tickets()
    sql = "SELECT * FROM tickets
           WHERE customer_id = $1 "
    values =[@id]
    result = SqlRunner.run(sql, values)
    Ticket.map_items(result)
  end

  def number_of_tickets()
    tickets().size()
  end

  def remaining_funds()
    @funds - films().map {|film| film.price.to_f}.sum
  end

  def update_funds()
    @funds = remaining_funds().round(2)
    update()
  end

  def has_funds?(film)
    @funds > film.price
  end

  def pay(film)
    result = @funds - film.price
    @funds = result.round(2)
    update()
  end

  def pay_discount(film)
    discount = film.price * 0.8
    result = @funds - discount
    @funds = result.round(2)
    update()
  end

  def fav_genre_showing?()
    film_genres = films().map {|film| film.genre}
    film_genres.include?(@fav_genre)
  end

  def fav_genre_equals_film_genre?(film)
    @fav_genre != film.genre
  end

  # Film Ratings Key: (U = 0, PG = 10, 12 = 12, 15 = 15, 18 = 18)
  def is_old_enough?(film)
    @age >= film.rating
  end

  def self.new_customer(first_name, last_name, funds, fav_genre, age)
    customer = Customer.new({'first_name' => first_name,
                             'last_name' => last_name,
                             'funds' => funds,
                             'fav_genre' => fav_genre,
                             'age' => age})
    customer.save()
  end

  def full_name()
    return "#{@first_name} #{@last_name}"
  end

  def self.map_items(result)
    result.map{|customer| Customer.new(customer)}
  end

  def self.returning_single_customer(results)
    return nil if results.first() == nil
    Customer.new(results.first())
  end

end
