# TO DO APP

To start your Phoenix server:

  * Run `docker compose run --rm web bash` 
  * Run `mix deps.get` inside the docker bash to install and setup dependencies
  * Run `mix ecto.create && mix ecto.migrate` inside the docker bash to setup your database
  * You can close your docker container
  * Run `docker compose up web` to start your phoenix server

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To run the tests

  * Run `docker compose run --rm test bash` 
  * Run `mix test` inside the docker bash to run all the tests

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
