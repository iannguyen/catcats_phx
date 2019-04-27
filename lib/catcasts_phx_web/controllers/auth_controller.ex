defmodule CatcastsPhxWeb.AuthController do
  use CatcastsPhxWeb, :controller
  plug Ueberauth

  alias CatcastsPhx.User

  def create(%{assigns: %{ueberauth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      provider: "google"
    }

    changeset = User.changeset(%User{}, user_params)
  end
end
