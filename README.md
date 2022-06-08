# README
# About project
Simple blog web application suing Ruby on Rails and PostgreSQL

This README file will describe project setup on MacOS.
# Ruby version
3.1.2

# System dependencies
Check if Rails is installed
```sh
    rails -v
```
If it doesn't recognise the command, run
```sh
    gem install rails
```
And try to check version again. It should output: Rails 7.0.3

Get the project files by cloning git repository
    git clone https://github.com/Evija-M/blog-prakse

Navigate to project root folder and install all the gems in the Gemfile
```sh    
    bundle install
```

# Homebrew
Install Homebrew
``` sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
```

# Database creation
PostgreSQL database is used for this project, you can install and run it locally. 
Open terminal and run 

```sh   
    brew install postgresql
```
Start PostgreSQL server

```sh
    brew services start postgresql
```
Log in as user "postgres"
```sh
    psql postgres
```

# Database initialization
You need to create 2 databases - development and test databases
In terminal where you have logged in as postgres user, run 
```sh
    create database blog_development;
    create database blog_test;
```
Or alternatively you can create databases using rails command `rails db:create` in root directory

If you need to view contents of certain database, you can connect by running
```sh
    \c database_name
```
Then you can run SQL commands
Quit by running
```sh
    \q
```
You can also connect to database by running
```sh
    rails dbconsole
```
It will automatiacally connect to development database of the project

Navigate to root directory and run
```sh
    rails db:migrate
```
This will run migration files and create necessary tables in database
# Testing

There are few test files made in the project that you can run, or you can create new ones. To run tests, run this command in root directory
```sh   
    rspec
```
This will run all spec files.
To run specific file:
```sh
    rspec filename
```
To run a specific test within the file:
```sh
    rspec filename:line
```
* Services (job queues, cache servers, search engines, etc.)
To open the project in browser, first you need to start rails server:
```sh
    rails s
```
Then type localhost:3000 in your browser and it will open root page

# Rubocop
Project uses Rubocop gem which checks code formatting
Run ` rubocop ` in root directory. It will output all mistakes, faults and imperfections of your code formatting. Some or the mistakes rubocop can fix automatically, run
```sh
    rubocop -A
``` 
Rest of them you might have to fix manually
