defmodule Challenge.Populate do
  alias Challenge.{Getnums, Sorting}

  def start_link do
    {:ok, agent} = Agent.start_link fn -> [] end
    agent
  end

  defp request(agent, _, []) do
    list = get_list(agent)
           |> Sorting.sort
    Agent.update(agent, fn _ -> list end)
    response(list)
  end
  defp request(agent, page, _), do: populate(agent, page + 1001)

  defp response(list) do
    url = "localhost:4000/api/list"
    body = Jason.encode!(%{"numbers" => %{"length" => length(list), "numbers" => list}})
    headers = [{"Content-type", "application/json"}]

    case HTTPoison.post(url, body, headers, [timeout: :infinity, recv_timeout: :infinity]) do
      {:ok, _} -> :ok
      {:error, _} -> response(list)
    end
  end


  def populate(agent, page) do
    IO.puts page
    list = Getnums.batch(page)
    Agent.update(agent, fn x -> list ++ x end)
    request(agent, page, list)
  end

  def get_list(agent) do
    Agent.get(agent, fn x -> x end)
  end

  def delete_agent(agent) do
    Agent.stop(agent)
  end
end
