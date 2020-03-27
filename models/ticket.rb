require_relative('../db/sql_runner.rb')
require_relative('../models/customer.rb')
require_relative('../models/film.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id)
           VALUES ($1, $2)
           RETURNING *"
    values = [@customer_id, @film_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def film()
    sql = "SELECT * FROM films
           WHERE id = $1"
    values = [@film_id]
    result = SqlRunner.run(sql, values).first
    return Film.new(result)
  end

  def customer()
    sql = "SELECT * FROM customers
           WHERE id = $1"
    values = [@customer_id]
    result = SqlRunner.run(sql, values).first
    return Customer.new(result)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    return Ticket.new(results.first())
  end

  def update()
    sql = "UPDATE tickets SET (customer_id, film_id)
           = ($1, $2)
           WHERE id = $3"
    values = [@customer_id, @film_id, @id]
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

  def self.map_items(result)
    result.map{|ticket| Ticket.new(ticket)}
  end

end
