# README

The setup procedure in this document assumes the system supports Docker and Postgres. For demonstration purposes, I am building the docker container for this project by mapping TCP port 80 inside the container to port 4435 on my host. 

## Ruby and Rails version
This project uses Rails version 6.0.3.2 with Ruby version 2.6.6.

## System dependencies
The system needs to support Postgres and Docker. 

## Configuration
Navigate to the project folder.
Buit the docker image using `docker build --no-cache -t sso .`.
Navigate to ` /config/ ` folder and copy `database.yml` into a file `database.local.yml` file. Open `database.local.yml` file and enter the Postgres host and port on your computer.  
Build a container for sso. As an example: 

```

docker run -it -d \
  --name sso \
  -e RAILS_ENV=development \
  -e TERM=xterm \
  -e HOME=/root \
  -v /Users/geyiliu/:/Users/geyiliu/ \
  -v /Users/geyiliu/projects/sso/:/home/app/www/ \
  -h sso-local \
  -p 4435:80 \
  -p 3004:3000 \
  sso
  
```

Enter the container `docker exec -it sso /bin/bash` and run `bundle install`.

While inside the container, run `rake db:create` and `rake db:migrate`.

Start the server with `rails s -p 80 -b 0.0.0.0`.

### Features
The homepage is the users index page. On that page, you can add additional users by filling in the form. Click "Edit" on the users table to edit the user you wish. Click "Delete" to delete the user you wish. 

On the user edit page, you can return to the users index page by clicking "All Users". 

### Technologies Used
On the logging side, techniques used for preventing PII leaks include configuring `config/initializers/filter_parameter_logging.rb` with appropriate parameters that may container personal information. As well, logstop gem was used to dynamically filter out information that may resemble personal information. 

On the database side, gem attr_encrypted was used to encrypt columns that may container personal information so that logging with PostgreSQL does not show such personal information.
