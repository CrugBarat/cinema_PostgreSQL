require_relative('../db/sql_runner.rb')

class Screening

  attr_reader :id, :ticket_sold
  attr_accessor :start_time, :end_time

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @start_time = options['start_time']
    @end_time = options['end_time']
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (start_time, end_time, film_id)
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

  # def movies()
  #   sql = "SELECT movies.*
  #          FROM movies
  #          INNER JOIN castings
  #          ON castings.movie_id = movies.id
  #          WHERE castings.star_id = $1"
  #   values = [@id]
  #   movie_data = SqlRunner.run(sql, values)
  #   Movie.map_items(movie_data)
  # end

  def self.find_by_id(id)
    sql = "SELECT * FROM screenings
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    return Screening.new(results.first())
  end

  def update()
    sql = "UPDATE screenings SET (start_time, end_time, film_id)
           = ($1, $2, $3)
           WHERE id = $4"
    values = [@start_time, @end_time, @film_id]
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

  def self.map_items(result)
    result.map{|screening| Screening.new(screening)}
  end

end
