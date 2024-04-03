defmodule HelldiversBarBotWeb.QuipLiveTest do
  use HelldiversBarBotWeb.ConnCase

  import Phoenix.LiveViewTest
  import HelldiversBarBot.QuipsFixtures

  @create_attrs %{text: "some text"}
  @update_attrs %{text: "some updated text"}
  @invalid_attrs %{text: nil}

  defp create_quip(_) do
    quip = quip_fixture()
    %{quip: quip}
  end

  describe "Index" do
    setup [:create_quip]

    test "lists all quips", %{conn: conn, quip: quip} do
      {:ok, _index_live, html} = live(conn, ~p"/quips")

      assert html =~ "Listing Quips"
      assert html =~ quip.text
    end

    test "saves new quip", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/quips")

      assert index_live |> element("a", "New Quip") |> render_click() =~
               "New Quip"

      assert_patch(index_live, ~p"/quips/new")

      assert index_live
             |> form("#quip-form", quip: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#quip-form", quip: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/quips")

      html = render(index_live)
      assert html =~ "Quip created successfully"
      assert html =~ "some text"
    end

    test "updates quip in listing", %{conn: conn, quip: quip} do
      {:ok, index_live, _html} = live(conn, ~p"/quips")

      assert index_live |> element("#quips-#{quip.id} a", "Edit") |> render_click() =~
               "Edit Quip"

      assert_patch(index_live, ~p"/quips/#{quip}/edit")

      assert index_live
             |> form("#quip-form", quip: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#quip-form", quip: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/quips")

      html = render(index_live)
      assert html =~ "Quip updated successfully"
      assert html =~ "some updated text"
    end

    test "deletes quip in listing", %{conn: conn, quip: quip} do
      {:ok, index_live, _html} = live(conn, ~p"/quips")

      assert index_live |> element("#quips-#{quip.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#quips-#{quip.id}")
    end
  end

  describe "Show" do
    setup [:create_quip]

    test "displays quip", %{conn: conn, quip: quip} do
      {:ok, _show_live, html} = live(conn, ~p"/quips/#{quip}")

      assert html =~ "Show Quip"
      assert html =~ quip.text
    end

    test "updates quip within modal", %{conn: conn, quip: quip} do
      {:ok, show_live, _html} = live(conn, ~p"/quips/#{quip}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Quip"

      assert_patch(show_live, ~p"/quips/#{quip}/show/edit")

      assert show_live
             |> form("#quip-form", quip: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#quip-form", quip: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/quips/#{quip}")

      html = render(show_live)
      assert html =~ "Quip updated successfully"
      assert html =~ "some updated text"
    end
  end
end
