defmodule Challenge.ResultTest do
  use Challenge.DataCase

  alias Challenge.Result

  describe "list" do
    alias Challenge.Result.Numbers

    @valid_attrs %{length: 42, numbers: []}
    @update_attrs %{length: 43, numbers: []}
    @invalid_attrs %{length: nil, numbers: nil}

    def numbers_fixture(attrs \\ %{}) do
      {:ok, numbers} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Result.create_numbers()

      numbers
    end

    test "list_list/0 returns all list" do
      numbers = numbers_fixture()
      assert Result.list_list() == [numbers]
    end

    test "get_numbers!/1 returns the numbers with given id" do
      numbers = numbers_fixture()
      assert Result.get_numbers!(numbers.id) == numbers
    end

    test "create_numbers/1 with valid data creates a numbers" do
      assert {:ok, %Numbers{} = numbers} = Result.create_numbers(@valid_attrs)
      assert numbers.length == 42
      assert numbers.numbers == []
    end

    test "create_numbers/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Result.create_numbers(@invalid_attrs)
    end

    test "update_numbers/2 with valid data updates the numbers" do
      numbers = numbers_fixture()
      assert {:ok, %Numbers{} = numbers} = Result.update_numbers(numbers, @update_attrs)
      assert numbers.length == 43
      assert numbers.numbers == []
    end

    test "update_numbers/2 with invalid data returns error changeset" do
      numbers = numbers_fixture()
      assert {:error, %Ecto.Changeset{}} = Result.update_numbers(numbers, @invalid_attrs)
      assert numbers == Result.get_numbers!(numbers.id)
    end

    test "delete_numbers/1 deletes the numbers" do
      numbers = numbers_fixture()
      assert {:ok, %Numbers{}} = Result.delete_numbers(numbers)
      assert_raise Ecto.NoResultsError, fn -> Result.get_numbers!(numbers.id) end
    end

    test "change_numbers/1 returns a numbers changeset" do
      numbers = numbers_fixture()
      assert %Ecto.Changeset{} = Result.change_numbers(numbers)
    end
  end
end
