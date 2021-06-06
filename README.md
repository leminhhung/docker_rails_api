# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


###### using git, after create responsitory on github #######
…or create a new repository on the command line
echo "# docker_rails_api" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/leminhhung/docker_rails_api.git
git push -u origin main
…or push an existing repository from the command line
git remote add origin https://github.com/leminhhung/docker_rails_api.git
git branch -M main
git push -u origin main

### using docker&docker-compose ####
#docker-compose run web rake db:create
#docker-compose run web bundle install

###### ADD DEVISE GEM (sign in/out/up) ######
gem "devise", "~> 4.8.0"
docker-compose run web rails generate devise:install
docker-compose run web rails generate devise User
docker-compose run web rails db:migrate

## add simple_token_authentication to authenticate through api call (https://github.com/gonzalo-bulnes/simple_token_authentication)
- gem 'simple_token_authentication', '~> 1.0' # see semver.org
- docker-compose build
- add "acts_as_token_authenticatable" to User model
- docker-compose run web rails g migration add_authentication_token_to_users "authentication_token:string{30}:uniq"
- docker-compose run web rake db:migrate
- checking model [docker-compose run web rails c ---> User.column_names]

## status code github
https://gist.github.com/mlanett/a31c340b132ddefa9cca

###### LOGIN VIA FACEBOOK API ######
- gem "koala", "~> 3.0.0"
- init facebook application: https://developers.facebook.com/ -> get appID, secrecID
- Run add more column: docker-compose run web rails g migration add_fields_to_users uid:string provider:string image:string
- docker-compose run web rails db:migrate