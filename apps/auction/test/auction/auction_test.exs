defmodule AuctionTest do
  use ExUnit.Case
  alias Auction.{Item, Repo}
  doctest Auction, import: true
  import Ecto.Query

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "list_items/0" do
    setup  do
      {:ok, item1} = Repo.insert(%Item{title: "Item 1"})
      {:ok, item2} = Repo.insert(%Item{title: "Item 2"})
      {:ok, item3} = Repo.insert(%Item{title: "Item 3"})
      %{items: [item1, item2, item3]}
    end

    test "Devolver todos los items de la DB", %{items: items} do
      assert(items == Auction.list_items())
    end
  end

  describe "get_item/1" do
    setup do
      {:ok, item1} = Repo.insert(%Item{title: "Item 1"})
      {:ok, item2} = Repo.insert(%Item{title: "Item 2"})
      %{items: [item1, item2]}
    end


    test "Conseguir un item por id", %{items: items} do
      item = Enum.at(items, 1)
      assert(^item = Auction.get_item(item.id))
    end
  end

  describe "insert_item/1" do
    test "añadir un item a la base de datos" do
      count_query = from i in Item, select: count(i.id)
      before_count = Repo.one(count_query)
      {:ok, _item} = Auction.insert_item(%{title: "item test"})
      assert Repo.one(count_query) == before_count + 1
    end

    test "El item añadido tiene los atributos correctos" do
      attrs = %{title: "test title", description: "test description"}
      {:ok, item} = Auction.insert_item(attrs)
      assert item.title == "test title"
      assert item.description == "test description"
    end

    test "Da error con un item con atributos invalidos" do
      {:error, _changeset} = Auction.insert_item(%{foo: :bar})
    end
  end

end
