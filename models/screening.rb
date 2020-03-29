require_relative('../db/sql_runner.rb')

class Screening

  attr_reader :id
  attr_accessor :start_time, :end_time, :film_id, :number_of_tickets

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @start_time = options['start_time']
    @end_time = options['end_time']
    @film_id = options['film_id'].to_i
    @number_of_tickets = options['number_of_tickets']
  end

  def save()
    sql = "INSERT INTO screenings
           (start_time, end_time, film_id)
           VALUES ($1, $2, $3)
           RETURNING *"
    values = [@start_time, @end_time, @film_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def update()
    sql = "UPDATE screenings
           SET (start_time, end_time, film_id, number_of_tickets)
           = ($1, $2, $3, $4)
           WHERE id = $5"
    values = [@start_time, @end_time, @film_id, @number_of_tickets, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screenings
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM screenings
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    self.returning_single_screening(results)
  end

  def self.find_by_film_id(film_id)
    sql = "SELECT * FROM screenings
           WHERE film_id = $1"
    values = [film_id]
    results = SqlRunner.run(sql, values)
    self.map_items(results)
  end

  def self.find_by_start_time(start_time)
    sql = "SELECT * FROM screenings
           WHERE start_time = $1"
    values = [start_time]
    results = SqlRunner.run(sql, values)
    self.map_items(results)
  end

  def self.find_by_end_time(end_time)
    sql = "SELECT * FROM screenings
           WHERE end_time = $1"
    values = [end_time]
    results = SqlRunner.run(sql, values)
    self.map_items(results)
  end

  def self.all_ascending_by_number_of_tickets()
    sql = "SELECT * FROM screenings
           ORDER BY number_of_tickets"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def self.all_ascending_by_start_time()
    sql = "SELECT * FROM screenings
           ORDER BY start_time"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def film()
    sql = "SELECT * FROM films
           WHERE id = $1"
    values = [@film_id]
    result = SqlRunner.run(sql, values)
    Screening.map_items(result)
  end

  def tickets()
    sql = "SELECT * FROM tickets
           WHERE screening_id = $1 "
    values =[@id]
    result = SqlRunner.run(sql, values)
    Ticket.map_items(result)
  end

  def number_of_tickets()
    tickets().size()
  end

  def update_number_of_tickets()
    @number_of_tickets = number_of_tickets()
    update()
  end

  def number_of_tickets_new_ticket_update()
    result = @number_of_tickets + 1
    @number_of_tickets = result
    update()
  end

  def self.most_tickets
    self.all().max_by {|screening| screening.number_of_tickets}
  end

  def screen()
    sql = "SELECT screens.capacity, screens.name, screenings.id
           FROM screens
           INNER JOIN films
           ON films.screen_id = screens.id
           INNER JOIN screenings
           ON screenings.film_id = films.id
           WHERE screenings.id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    Screen.map_items(result).first()
  end

  def capacity()
    screen().capacity.to_i
  end

  def over_capacity?()
    capacity() <= number_of_tickets()
  end

  def self.create_a_screening(start_time, end_time, film_id)
    sql = "INSERT INTO screening
           (start_time, end_time, film_id)
           VALUES ($1, $2, $3)
           RETURNING *"
    values = [start_time, end_time, film_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all_ascending_by_number_of_tickets()
    sql = "SELECT * FROM screenings
           ORDER BY number_of_tickets"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def self.map_items(result)
    result.map{|screening| Screening.new(screening)}
  end

  def self.returning_single_screening(results)
    return nil if results.first() == nil
    return Screening.new(results.first())
  end

end
