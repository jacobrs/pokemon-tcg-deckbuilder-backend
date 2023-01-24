# README

This is a GraphQL Ruby on Rails backend for a Pokemon TCG deck builder. The coresponding frontend can be found [here](https://github.com/jacobrs/pokemon-tcg-deckbuilder-frontend).

## Pre-requisites
* Ruby and rails
* PostgreSQL (running locally on default port)

## Getting Started

1. Clone the repository
2. Run `bundle install`
3. Run `rails db:create db:migrate db:seed` to create the database and run pending migrations
4. Run `bin/rails server` to start the server on port `3001`
5. GraphiQL should be running on `http://localhost:3001/graphiql` to test out queries and view schema

## Running Tests

`bin/rails test` can be used to run tests.

## Screenshots

<img src="https://github.com/jacobrs/pokemon-tcg-deckbuilder-backend/blob/main/docs/graphiql_screenshot.png"/>
