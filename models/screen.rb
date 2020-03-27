require_relative('../db/sql_runner.rb')

class Screen

  attr_reader :id
  attr_accessor :name, :capacity

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @capacity = options['capacity']
  end

  def save()
    sql = "INSERT INTO screens (name, capacity)
           VALUES ($1, $2)
           RETURNING *"
    values = [@name, @capacity]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screens"
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
    sql = "SELECT * FROM screens
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    return Screen.new(results.first())
  end

  def update()
    sql = "UPDATE screens SET (name, capacity)
           = ($1, $2)
           WHERE id = $3"
    values = [@name, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM screens
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screens"
    SqlRunner.run(sql)
  end

  def self.map_items(result)
    result.map{|screen| Screen.new(screen)}
  end

end
