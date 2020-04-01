require_relative('../db/sql_runner.rb')

class AppData

  attr_reader :id
  attr_accessor :title, :start_time, :end_time, :genre, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @start_time = options['start_time']
    @end_time = options['end_time']
    @genre = options['genre']
    @price = options['price']
  end

  def self.all()
    sql = "SELECT films.title, films.price, films.genre, screenings.start_time, screenings.end_time
           FROM screenings
           INNER JOIN films
           ON films.id = screenings.film_id
           ORDER BY screenings.start_time"
    result = SqlRunner.run(sql)
    self.map_items(result)
  end

  def self.map_items(result)
    result.map{|appdata| AppData.new(appdata)}
  end

end
