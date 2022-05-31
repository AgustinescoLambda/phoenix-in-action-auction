defmodule Auction do
  alias Auction.{Repo, Item, User, Password, Bid}
  import Ecto.Query

  @repo Repo


  #Items---
  def list_items do
    @repo.all(Item)
  end

  def edit_item(id) do
    get_item(id)
    |> Item.changeset()
  end

  def get_item(id) do
    @repo.get!(Item,id)
  end

  def get_item_with_bids(id) do
    id
    |> get_item()
    |> @repo.preload(bids: [:user])
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def insert_item(attrs) do
    %Item{} |> Item.changeset(attrs) |> @repo.insert()
  end

  def delete_item(%Auction.Item{} = item), do: @repo.delete(item)

  def update_item(%Auction.Item{} = item , updates) do
    Item.changeset(item,updates)
    |> @repo.update()
  end

  def new_item(), do: Item.changeset(%Item{})

  #Users----

  def get_user(id) do
    @repo.get!(User,id)
  end

  def get_user_with_bids(id) do
    id
      |> get_user()
      |> @repo.preload(bids: [:item])
  end

  @doc """
    consigue un usuario de la base de datos que tiene los mismos username y password

    ## Return values
    Dependiendo de lo que se consiga de la base de datos, hay dos tipos de retornos
      * una estructura "Auction.User" en caso de que se encuentre un registro que tengo los mismos "username" y "password" que los pasados por paramtro
      * "false" cuando no se encuentra ningun registro con los valores "username" y "password" iguales a los pasados por paramtro

    ## Ejemplos

      iex> insert_user(%{username: "ejemplo", password: "ejemplo", password_confirmation: "ejemplo", email_address: "ejemplo@ejemplo.com"})
      iex> result = get_user_by_username_and_password("ejemplo", "ejemplo")
      iex> match?(%Auction.User{username: "ejemplo"}, result)
      true

      iex > get_user_by_username_and_password("username_erroneo", "password_erroneo")
      false
  """
  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- @repo.get_by(User, %{username: username}),
    true <- Password.verify_with_hash(password, user.hashed_password) do user
    else
    _ -> Password.dummy_verify
    end
  end

  def new_user, do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
      |> User.changeset_with_password(params)
      |> @repo.insert

  end

  #bids----

  def insert_bid(params) do
    %Bid{}
      |> Bid.changeset(params)
      |> @repo.insert()
  end

  def new_bid, do: Bid.changeset(%Bid{})

  def get_bids_from_user(user) do
    query=
      from b in Bid,
      where: b.user_id == ^user.id,
      order_by: [desc: :inserted_at],
      preload: :item,
      limit: 10
    @repo.all(query)
  end
end
