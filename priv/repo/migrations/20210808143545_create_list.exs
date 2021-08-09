defmodule Challenge.Repo.Migrations.CreateList do
  use Ecto.Migration

  def change do
    create table(:list) do
      add :length, :integer
      add :numbers, {:array, :float}

      timestamps()
    end

  end
end
