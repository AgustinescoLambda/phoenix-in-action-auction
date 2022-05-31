defmodule AuctionWeb.ItemControllerTest do
  use AuctionWeb, :controller
  use ExUnit.Case
  use AuctionWeb.ConnCase

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Auction.Repo)
  end

  test "GET /", %{conn: conn} do
    {:ok, _item} = Auction.insert_item(%{title: "test item"})
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "test item"
  end

  describe "POST /" do
    test "Con parametros correctos crear item", %{conn: conn} do
      before_count= Enum.count(Auction.list_items())
      post conn, "/items", %{"item" => %{title: "item 1"}}
      assert Enum.count(Auction.list_items) == before_count + 1
    end

    test "Con parametros correctos redireccionar al item", %{conn: conn} do
      conn = post conn, "/items", %{"item" => %{title: "item 1"}}
      assert redirected_to(conn) =~ ~r|/items/\d+|
    end

    test "Con parametros invalidos no añadir item", %{conn: conn} do
      before_count= Enum.count(Auction.list_items())
      post conn, "/items", %{"item" => %{cualquier_cosa: "item 1"}}
      assert Enum.count(Auction.list_items) == before_count
    end

    test "Con parametros invalidos mostrar el formulario nuevamente", %{conn: conn} do
      conn = post conn, "/items", %{"item" => %{cualquier_cosa: "item 1"}}
      assert html_response(conn, 200) =~ "<h1> New Item </h1>"
    end
  end
end
