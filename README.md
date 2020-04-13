== README

* Ruby and Rails version
This project uses Rails version 6.0.2.2 with Ruby version 2.6.5.

* System dependencies
The system needs to support Postgres and Docker. 

* Configuration
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
  -v /home/johnson/:/home/johnson/ \
  -v /home/johnson/projects/sso/:/home/app/www/ \
  -h sso-local \
  -p 4435:80 \
  -p 3004:3000 \
  sso
  
```

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.