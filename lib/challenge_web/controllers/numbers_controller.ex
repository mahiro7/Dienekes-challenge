defmodule ChallengeWeb.NumbersController do
  use ChallengeWeb, :controller

  alias Challenge.Result
  alias Challenge.Result.Numbers

  action_fallback ChallengeWeb.FallbackController

  alias Challenge.Populate

  def start(_, _) do
  end

  def index(conn, _params) do
    list = Result.list_list()
           |> Enum.filter(fn %{id: x} -> x == 1 end)
    render(conn, "index.json", list: list)
  end

  def create(conn, %{"numbers" => numbers_params}) do
    with {:ok, %Numbers{} = numbers} <- Result.create_numbers(numbers_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.numbers_path(conn, :show, numbers))
      |> render("cshow.json", numbers: numbers)
    end
  end
  #def create(conn, _) do
  #  agent = Populate.start_link
  #  task = Task.async(fn -> agent |> Populate.populate(1) end)
  #  conn |> put_status(:ok) |> render("requesting.json")
  #end

  def get_number_per_page(id, separated) do
    case separated
    |> Enum.filter(fn {_, x} -> x == id end) do
      [{numbers, _}] -> numbers
      [] -> []
    end
  end


  def show(conn, %{"id" => id}) do
    {trueid, _} = Integer.parse id
    [%{numbers: allnumbers}] = Result.list_list()
                               |> Enum.filter(fn %{id: x} -> x == 1 end)
    separated = allnumbers
                |> Enum.chunk_every(100)
                |> Enum.with_index

    numbers = get_number_per_page(trueid, separated)

    result = [%Challenge.Result.Numbers{
      numbers: numbers
    }]

    render(conn, "show.json", numbers: result)
  end

  def update(conn, %{"id" => id, "numbers" => numbers_params}) do
    numbers = Result.get_numbers!(id)

    with {:ok, %Numbers{} = numbers} <- Result.update_numbers(numbers, numbers_params) do
      render(conn, "show.json", numbers: numbers)
    end
  end

  def delete(conn, %{"id" => id}) do
    numbers = Result.get_numbers!(id)

    with {:ok, %Numbers{}} <- Result.delete_numbers(numbers) do
      send_resp(conn, :no_content, "")
    end
  end
end
