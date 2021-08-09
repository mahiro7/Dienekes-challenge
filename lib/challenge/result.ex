defmodule Challenge.Result do
  @moduledoc """
  The Result context.
  """

  import Ecto.Query, warn: false
  alias Challenge.Repo

  alias Challenge.Result.Numbers

  @doc """
  Returns the list of list.

  ## Examples

      iex> list_list()
      [%Numbers{}, ...]

  """
  def list_list do
    Repo.all(Numbers)
  end

  @doc """
  Gets a single numbers.

  Raises `Ecto.NoResultsError` if the Numbers does not exist.

  ## Examples

      iex> get_numbers!(123)
      %Numbers{}

      iex> get_numbers!(456)
      ** (Ecto.NoResultsError)

  """
  def get_numbers!(id), do: Repo.get!(Numbers, id)

  @doc """
  Creates a numbers.

  ## Examples

      iex> create_numbers(%{field: value})
      {:ok, %Numbers{}}

      iex> create_numbers(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_numbers(attrs \\ %{}) do
    %Numbers{}
    |> Numbers.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a numbers.

  ## Examples

      iex> update_numbers(numbers, %{field: new_value})
      {:ok, %Numbers{}}

      iex> update_numbers(numbers, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_numbers(%Numbers{} = numbers, attrs) do
    numbers
    |> Numbers.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a numbers.

  ## Examples

      iex> delete_numbers(numbers)
      {:ok, %Numbers{}}

      iex> delete_numbers(numbers)
      {:error, %Ecto.Changeset{}}

  """
  def delete_numbers(%Numbers{} = numbers) do
    Repo.delete(numbers)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking numbers changes.

  ## Examples

      iex> change_numbers(numbers)
      %Ecto.Changeset{data: %Numbers{}}

  """
  def change_numbers(%Numbers{} = numbers, attrs \\ %{}) do
    Numbers.changeset(numbers, attrs)
  end
end
