FROM phusion/passenger-ruby25:0.9.35

LABEL description="libctf" \
      maintainer="elttam"

#ENV FLAG libctf{foo}
# FLAG can be defined at build time and will not be set as env variable duing run

# create and copy contents of app to the container
ADD webapp /home/app/webapp
ADD nginx/app.conf /etc/nginx/sites-enabled/

# install and requirements
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
RUN gem update --system
RUN bundle install --gemfile /home/app/webapp/Gemfile

# expose required ports
EXPOSE 80

