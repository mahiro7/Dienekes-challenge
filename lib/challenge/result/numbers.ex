defmodule Challenge.Result.Numbers do
  use Ecto.Schema
  import Ecto.Changeset

  schema "list" do
    field :length, :integer
    field :numbers, {:array, :float}

    timestamps()
  end

  @doc false
  def changeset(numbers, attrs) do
    numbers
    |> cast(attrs, [:length, :numbers])
    |> validate_required([:length, :numbers])
  end
end
