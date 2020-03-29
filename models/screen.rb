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

  def self.find_by_id(id)
    sql = "SELECT * FROM screens
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    self.returning_single_screen(results)
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM screens
           WHERE name = $1"
    values = [name]
    results = SqlRunner.run(sql, values)
    self.returning_single_screen(results)
  end

  def self.find_by_capacity_range(cap1, cap2)
    sql = "SELECT * FROM screens
           WHERE capacity >= $1 AND capacity <= $2"
    values = [cap1, cap2]
    results = SqlRunner.run(sql, values)
    self.map_items(results)
  end

  def self.all_ascending_capacity()
    sql = "SELECT * FROM screens
           ORDER BY capacity"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def films()
    sql = "SELECT * FROM films
           WHERE screen_id = $1 "
    values =[@id]
    result = SqlRunner.run(sql, values)
    Film.map_items(result)
  end

  def self.create_a_screen(name, capacity)
    sql = "INSERT INTO screens (name, capacity)
           VALUES ($1, $2)
           RETURNING *"
    values = [name, capacity]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.map_items(result)
    result.map{|screen| Screen.new(screen)}
  end

  def self.returning_single_screen(results)
    return nil if results.first() == nil
    return Screen.new(results.first())
  end

end
