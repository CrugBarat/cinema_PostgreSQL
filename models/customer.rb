require_relative('../db/sql_runner.rb')

class Customer

  attr_reader :id
  attr_accessor :first_name, :last_name, :funds, :fav_genre

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @funds = options['funds']
    @fav_genre = options['fav_genre']
  end

  def save()
    sql = "INSERT INTO customers (first_name, last_name, funds, fav_genre)
           VALUES ($1, $2, $3, $4)
           RETURNING *"
    values = [@first_name, @last_name, @funds, @fav_genre]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def update()
    sql = "UPDATE customers SET (first_name, last_name, funds, fav_genre)
           = ($1, $2, $3, $4)
           WHERE id = $5"
    values = [@first_name, @last_name, @funds, @fav_genre, @id]
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

  def self.map_items(result)
    result.map{|customer| Customer.new(customer)}
  end

  def films()
    sql = "SELECT films.*
           FROM films
           INNER JOIN tickets
           ON tickets.film_id = films.id
           WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Film.map_items(result)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    return Customer.new(results.first())
  end

  def tickets()
    sql = "SELECT * FROM tickets
           WHERE customer_id = $1 "
    values =[@id]
    result = SqlRunner.run(sql, values)
    Ticket.map_items(result)
  end

  def self.number_of_tickets(customer)
    result = customer.tickets
    result.size()
  end

end
