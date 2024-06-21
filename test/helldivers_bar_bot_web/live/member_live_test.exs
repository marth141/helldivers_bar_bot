defmodule HelldiversBarBotWeb.HelldiverLiveTest do
  use HelldiversBarBotWeb.ConnCase

  import Phoenix.LiveViewTest
  import HelldiversBarBot.HelldiversFixtures

  @create_attrs %{
    name: "some name",
    discord_id: "some discord_id",
    messages_sent: 42,
    wallet: "120.5"
  }
  @update_attrs %{
    name: "some updated name",
    discord_id: "some updated discord_id",
    messages_sent: 43,
    wallet: "456.7"
  }
  @invalid_attrs %{name: nil, discord_id: nil, messages_sent: nil, wallet: nil}

  defp create_helldiver(_) do
    helldiver = helldiver_fixture()
    %{helldiver: helldiver}
  end

  describe "Index" do
    setup [:create_helldiver]

    test "lists all helldivers", %{conn: conn, helldiver: helldiver} do
      {:ok, _index_live, html} = live(conn, ~p"/helldivers")

      assert html =~ "Listing Helldivers"
      assert html =~ helldiver.name
    end

    test "saves new helldiver", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/helldivers")

      assert index_live |> element("a", "New Helldiver") |> render_click() =~
               "New Helldiver"

      assert_patch(index_live, ~p"/helldivers/new")

      assert index_live
             |> form("#helldiver-form", helldiver: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#helldiver-form", helldiver: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/helldivers")

      html = render(index_live)
      assert html =~ "Helldiver created successfully"
      assert html =~ "some name"
    end

    test "updates helldiver in listing", %{conn: conn, helldiver: helldiver} do
      {:ok, index_live, _html} = live(conn, ~p"/helldivers")

      assert index_live |> element("#helldivers-#{helldiver.id} a", "Edit") |> render_click() =~
               "Edit Helldiver"

      assert_patch(index_live, ~p"/helldivers/#{helldiver}/edit")

      assert index_live
             |> form("#helldiver-form", helldiver: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#helldiver-form", helldiver: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/helldivers")

      html = render(index_live)
      assert html =~ "Helldiver updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes helldiver in listing", %{conn: conn, helldiver: helldiver} do
      {:ok, index_live, _html} = live(conn, ~p"/helldivers")

      assert index_live |> element("#helldivers-#{helldiver.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#helldivers-#{helldiver.id}")
    end
  end

  describe "Show" do
    setup [:create_helldiver]

    test "displays helldiver", %{conn: conn, helldiver: helldiver} do
      {:ok, _show_live, html} = live(conn, ~p"/helldivers/#{helldiver}")

      assert html =~ "Show Helldiver"
      assert html =~ helldiver.name
    end

    test "updates helldiver within modal", %{conn: conn, helldiver: helldiver} do
      {:ok, show_live, _html} = live(conn, ~p"/helldivers/#{helldiver}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Helldiver"

      assert_patch(show_live, ~p"/helldivers/#{helldiver}/show/edit")

      assert show_live
             |> form("#helldiver-form", helldiver: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#helldiver-form", helldiver: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/helldivers/#{helldiver}")

      html = render(show_live)
      assert html =~ "Helldiver updated successfully"
      assert html =~ "some updated name"
    end
  end
end
