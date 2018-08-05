defmodule CatcastsPhxWeb.AuthControllerTest do
  use CatcastsPhxWeb.ConnCase

  test "redirects user to Google for authentication", %{conn: conn} do
    conn = get conn, "/auth/google"
    assert redirected_to(conn, 302)
  end
end

