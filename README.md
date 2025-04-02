# README

This README would normally document whatever steps are necessary to get the
application up and running.


* Ruby version >> 

* System dependencies

  1. General Requirements
        Ruby (Recommended version: Rails 8.0.2 or higher)

        Bundler (gem install bundler)

        Node.js & Yarn (for asset pipeline if applicable)

        PostgreSQL (for database management)

2. Database Dependencies
        PostgreSQL (Ensure it’s installed and running)

        Ubuntu: sudo apt install postgresql postgresql-contrib libpq-dev

        Windows: Install via PostgreSQL Installer

        macOS: brew install postgresql

3. Web Server
        Puma (included in your Gemfile)

4. Debugging & Development Tools
        Brakeman (Static security analysis)

        Rubocop (Omakase style guide for Rails)

        Debug (For debugging Rails applications)

5. Authentication & Security
        Devise (For user authentication)

        Devise-JWT (For JWT-based authentication)

        bcrypt (For password hashing)

6. Rails Caching & Job Queueing
        Solid Cache

        Solid Queue

        Solid Cable

7. Miscellaneous
        Dotenv (For managing environment variables)

        Kamal (For Docker deployment)

        Thruster (For Puma optimization)

        Bootsnap (For faster application booting)

        


* Configuration
1. .env file for database configuration and jwt secretkey
        DATABASE_NAME=name_of_your_database
        DATABASE_USER=myuser
        DATABASE_PASSWORD=mypassword
        DATABASE_HOST=localhost
        DATABASE_PORT=5432

        DEVISE_JWT_SECRET_KEY=your_secret_key

* Database creation
1. database.yml
        default: &default
        adapter: postgresql
        encoding: unicode
        pool: 5
        username: <%= ENV['DATABASE_USER'] %>
        password: <%= ENV['DATABASE_PASSWORD'] %>
        host: <%= ENV['DATABASE_HOST'] %>
        port: <%= ENV['DATABASE_PORT'] %>

        development:
        <<: *default
        database: <%= ENV['DATABASE_NAME'] %>

        test:
        <<: *default
        database: task_manager_api_test

        production:
        <<: *default
        database: task_manager_api_production
        username: <%= ENV['DATABASE_USER'] %>
        password: <%= ENV['DATABASE_PASSWORD'] %>
2. Run the following commands to create and set up the database:

        rails db:create
        rails db:migrate
        rails db:seed

* How to test in postman
1. run rails server
2. open postman import the postman.json file
3. create a user or sign in using an existing user from db/seeds file
4. create, update, or destroy task as you will

note
: creating new user will not generate a task, however using the seeded user from db/seeds will have 3 completed task, 3 not ompleted tasks and 3 overdue tasks.

:  a user can only alter their own task


