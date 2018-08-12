defmodule CatcastsPhxWeb.AuthControllerTest do
  use CatcastsPhxWeb.ConnCase
  alias CatcastsPhx.Repo
  alias CatcastsPhx.User

  test "redirects user to Google for authentication", %{conn: conn} do
    conn = get conn, "/auth/google"
    assert redirected_to(conn, 302)
  end

  @ueberauth %{
    credentials: %{
      token: 'asdfasdfasdfasdf',
    },
    info: %{
      email: 'pusheen@pmd.com',
      first_name: 'Pusheen',
      last_name: 'The Cat',
      provider: :google
    }
  }

  test "creates the user from Google information", %{conn: conn} do
    conn = conn
           |> assign(:ueberauth, @ueberauth)
           |> get("/auth/google/callback")

    users = User |> Repo.all

    assert Enum.count(users) == 1
    assert get_flash(conn, :info) =~ "Thank you for signing in!"
  end
end
