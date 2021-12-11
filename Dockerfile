FROM ruby:2.7.2

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

RUN apt-get update -qq && apt-get install -y libmagickwand-dev ghostscript

RUN apt-get install -y postgresql-client

ENV TZ=America/Fortaleza
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /var/www/bucks
RUN mkdir -p $RAILS_ROOT

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

# Setting env up
ENV RAILS_ENV=${RAILS_ENV}
ENV RACK_ENV=${RAILS_ENV}
ENV RAILS_LOG_TO_STDOUT=true
ENV DATABASE_HOST=${DATABASE_HOST}
ENV DATABASE_PORT=${DATABASE_PORT}
ENV DATABASE_USER=${DATABASE_USER}
ENV DATABASE_PASSWORD=${DATABASE_PASSWORD}
ENV RAILS_SERVE_STATIC_FILES=true
ENV DEVISE_JWT_SECRET_KEY=f0fa41451bf7415b8f0507901cb42e4ba3d4bc05416da1cb940f3762f167733bd242f6b48eb39c920a95da939d9130ae71eaf140919d8376805e13e3df241ad6

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5
#RUN rails db:create db:schema:load db:fixtures:load

# Adding project files
COPY . .
#COPY .env.example .env
COPY ./docker/docker-entrypoint.sh .
COPY ./docker/start-entrypoint.sh .
RUN chmod +x ./docker-entrypoint.sh
RUN chmod +x ./start-entrypoint.sh


EXPOSE 3000
#ENTRYPOINT ./entrypoint.sh
#CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]


ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["puma"]
