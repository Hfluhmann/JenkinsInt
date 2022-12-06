FROM ruby:3.1.3

#RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY ../code/Gemfile ../code/Gemfile.lock ./
RUN bundle lock --add-platform x86_64-linux
RUN bundle install

COPY ../code .

RUN rails db:migrate
RUN rails db:seed

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]