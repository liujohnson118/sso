# README

The setup procedure in this document assumes the system supports Docker and Postgres. For demonstration purposes, I am building the docker container for this project by mapping TCP port 80 inside the container to port 4435 on my host. 

## Ruby and Rails version
This project uses Rails version 6.0.2.2 with Ruby version 2.6.5.

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
  -v /home/johnson/:/home/johnson/ \
  -v /home/johnson/projects/sso/:/home/app/www/ \
  -h sso-local \
  -p 4435:80 \
  -p 3004:3000 \
  sso
  
```

Set up your own IDP using an IDP of your choice. In my example, I used Onelogin SAML Test Connector (SP Shibboleth) and Okta SAML App Integration Wizard. If you use these 2 apps, you can follow settings in `config/settings/development.yml` to set up. 

Go to `app/assets/image` folder and upload images of your IDP in PNG format. Name the images in the form of your IDP name (make sure it matches up with the keys in `settings/identity_providers` in `config/settings/development.yml`).

Enter the container `docker exec -it sso /bin/bash` and run `bundle install`.

While inside the container, run `rake db:create` and `rake db:migrate`.

Start the server with `rails s -p 80 -b 0.0.0.0`.

### Features
On the login page, you can clik the link to `Sign In`, `Sign Up`, `Sign-in Partners` to perform logging in as a regular user managed by Devise, registering as a regular user managed by Devise, or signning in using one of the identity providers. 

Once signed in, you will see a data table utilizing `jQuery`'s `dataTables` library that shows the 24h, 7d, and 30d prices of bitcoin in different currencies. 

If you are logged in using one of the IDPs, you can click the `Exit to #{IDP name}` on the top right corner of the header to be logged out of the app (no SLO request is sent) and redirected back to the IDP's homepage where you can see all your apps. You can log out of the IDP there.   

### Video Demo
https://www.youtube.com/watch?v=AUoJrUeLV0s
