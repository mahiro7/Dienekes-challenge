defmodule Challenge.Getnums do
  HTTPoison.start

  alias Challenge.Sorting

  defp get_numbers(body, current, acc) do
    case body |> Jason.decode! do
      %{"numbers" => array} ->
        array
      %{"error" => message} ->
        #IO.puts 'Error at page #{current}, message: #{message}. Retrying...'
        fetch(current, acc)
    end
  end

  def fetch(current, acc \\ []) do
    response = HTTPoison.request(:get, "http://challenge.dienekes.com.br/api/numbers?page=#{current}", [], [timeout: :infinity, recv_timeout: :infinity])

    case response do
      {:error, %HTTPoison.Error{reason: :timeout}} ->
        IO.puts 'HTTPoison.Error :timeout, requesting again...'
        Process.sleep(1000)
        fetch(current, acc)
      {:error, %HTTPoison.Error{reason: :checkout_timeout}} ->
        IO.inspect("fixing timeout")
        :hackney_pool.stop_pool(:default)
        Process.sleep(1000)
        fetch(current, acc)
      {:error, %HTTPoison.Error{reason: :closed}} ->
        IO.puts 'HTTPoison.Error :closed, requesting again...'
        Process.sleep(1000)
        HTTPoison.start
        fetch(current, acc)
      {:error, %HTTPoison.Error{reason: :nxdomain}} ->
        IO.puts 'Invalid request url'
      {:error, _} ->
        fetch(current, acc)
      {:ok, %{body: body}} ->
        _new_acc = acc ++ (_array = get_numbers(body, current, acc))
    end
  end

  def batch(page) do
    tasks = for n <- 0..1000 do
      Task.async(fn -> fetch(n + page) end)
    end
    list = tasks
           |> Enum.map(fn x -> Task.await(x, :infinity) |> Sorting.sort end)
           |> List.flatten
           |> Sorting.sort
    list
  end
end
