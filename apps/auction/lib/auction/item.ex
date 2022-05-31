defmodule Auction.Item do
  use Ecto.Schema
  import Ecto.Changeset


  schema "items" do
    field :title, :string
    field :description, :string
    field :ends_at, :utc_datetime
    has_many :bids, Auction.Bid
    timestamps()
  end

  def changeset(item, params \\ %{}) do
    item
      |> cast(params, [:title, :description, :ends_at])
      |> validate_required(:title)
      |> validate_length(:title, min: 3)
      |> validate_length(:description, max: 200)
      |> validate_change(:ends_at, &validar/2)

  end

  defp validar(:ends_at,termina_en) do
    case DateTime.compare(termina_en, DateTime.utc_now()) do
      :lt -> [ends_at: "La fecha no puede ser en el pasado!"]
      :eq -> [ends_at: "La fecha no puede ser hoy"]
      _ -> []
    end

  end
end
