DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS screens;

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  funds DECIMAL,
  fav_genre VARCHAR(255),
  age INT
);

CREATE TABLE screens (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  capacity INT
);

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255),
  price DECIMAL,
  rating INT,
  screen_id INT REFERENCES screens(id) ON DELETE CASCADE
);

CREATE TABLE screenings (
  id SERIAL PRIMARY KEY,
  start_time TIME(0),
  end_time TIME(0),
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  number_of_tickets INT
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  screening_id INT REFERENCES screenings(id) ON DELETE CASCADE
);
