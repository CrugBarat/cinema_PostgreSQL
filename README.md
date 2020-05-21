<img src="https://github.com/CrugBarat/my_files/blob/master/cinema/cinema1.png" width="300"> <img src="https://github.com/CrugBarat/my_files/blob/master/cinema/cinema2.png" width="300"> <img src="https://github.com/CrugBarat/my_files/blob/master/cinema/cinema3.png" width="300"> <img src="https://github.com/CrugBarat/my_files/blob/master/cinema/cinema4.png" width="300"> <img src="https://github.com/CrugBarat/my_files/blob/master/cinema/cinema5.png" height="180"> <img src="https://github.com/CrugBarat/my_files/blob/master/cinema/cinema6.png" height="180"> <img src="https://github.com/CrugBarat/my_files/blob/master/cinema/cinema7.png" height="180">

# Cinema

A basic cinema app which shows available movies, showtimes and provides a simple booking form.

**Programming Language**: Ruby

**Markup/Styling**: HTML5/CSS3

**Web App Framework**: Sinatra

**Db**: PostgreSQL

This exercise was tasked to me by CodeClan, Glasgow where I studied towards a PDA Level 8 in Professional Software Development. The exercise brief can be found below.

---

# Brief

Create a system that handles bookings for our newly built cinema! It’s enough if you can call your methods in pry, don’t worry about an interface.

Your app should have:

Customers:
- name
- funds

Films:
- title
- price

Tickets:
- customer_id
- film_id

Your app should be able to:
- Create customers, films and tickets
- CRUD actions (create, read, update, delete) customers, films and tickets.
- Show which films a customer has booked to see, and see which customers are coming to see one film.

**Basic extensions**

- Buying tickets should decrease the funds of the customer by the price
- Check how many tickets were bought by a customer
- Check how many customers are going to watch a certain film

**Advanced extensions**

- Create a screenings table that lets us know what time films are showing
- Write a method that finds out what is the most popular time (most tickets sold) for a given film
- Limit the available tickets for screenings.
Add any other extensions you think would be great to have at a cinema!

---

# Setup

- Clone/save the repository

- Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) and [PostgreSQL](http://www.postgresqltutorial.com/install-postgresql/)

**In Terminal**:

- Install Sinatra

```
gem install sinatra

```

- Create a cinema database

```
createdb cinema

```

- Access the cinema directory and create the database tables

```
psql -d cinema -f db/cinema.sql

```
- Populate the tables from the db directory

```
ruby console.rb

```

- Run the app

```
ruby controller.rb

```

- Click [localhost](http://localhost:4567/home)
