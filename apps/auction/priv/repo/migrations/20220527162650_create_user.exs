defmodule Auction.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table("users") do
      add :username, :string
      add :email_address, :string
      add :hashed_password, :string
      timestamps()
    end

    create unique_index(:users, [:username])
    create unique_index(:users, [:email_address])
  end
end
