FROM phusion/passenger-ruby26

RUN apt-get update

RUN gem update --system
RUN gem install bundler
# ------ App Setup ------
WORKDIR /home/app/www
ADD Gemfile /home/app/www/Gemfile
ADD Gemfile.lock /home/app/www/Gemfile.lock
RUN bundle install

ADD ./ /home/app/www/
RUN mkdir -p /home/app/www/tmp
RUN rm -rf /home/app/www/tmp/*
RUN rm -rf /home/app/www/log/*
RUN /bin/bash -l -c 'cd /home/app/www && bundle install'

RUN echo "cd /home/app/www" >> /root/.bashrc
RUN echo "export PATH=$PATH:/home/app/www/bin/" >> /root/.bashrc
RUN echo "cd /home/app/www" >> /home/app/.bashrc
RUN echo "export PATH=$PATH:/home/app/www/bin/" >> /home/app/.bashrc
RUN chown -R app:app /home/app/

ADD docker/nginx/app.conf /etc/nginx/sites-enabled/app.conf

ENV TERM xterm
