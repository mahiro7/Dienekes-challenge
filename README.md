# Dienekes Challenge

To execute the project:

  * Install dependencies with `mix deps.get`
  * Configure your database in config/dev.exs
  * Create and migrate your database with `mix ecto.setup`
  * Start IEx and start Phoenix endpoint with `iex -S mix phx.server`
  * Start the Dienekes' API requests with `Challenge.start`
  * Await process to beign done `i.e. :ok`
  * GET `localhost:4000/api/list/:page` to get numbers
  * **WARNING**: GET on `localhost:4000/api/list` will return **ALL** numbers
