defmodule Challenge do
  HTTPoison.start

  @moduledoc """
  Challenge keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def start do
    Challenge.Populate.start_link
    |> Challenge.Populate.populate(1)
    # HTTPoison.post("localhost:4000/api/", [], [{"Content-type", "application/json"}], [timeout: :infinity, recv_timeout: :infinity])
  end
end
