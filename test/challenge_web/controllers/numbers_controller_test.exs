defmodule ChallengeWeb.NumbersControllerTest do
  use ChallengeWeb.ConnCase

  alias Challenge.Result
  alias Challenge.Result.Numbers

  @create_attrs %{
    length: 42,
    numbers: []
  }
  @update_attrs %{
    length: 43,
    numbers: []
  }
  @invalid_attrs %{length: nil, numbers: nil}

  def fixture(:numbers) do
    {:ok, numbers} = Result.create_numbers(@create_attrs)
    numbers
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all list", %{conn: conn} do
      conn = get(conn, Routes.numbers_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

end
