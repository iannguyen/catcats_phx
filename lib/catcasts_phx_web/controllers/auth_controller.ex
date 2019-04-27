defmodule CatcastsPhxWeb.AuthController do
  use CatcastsPhxWeb, :controller
  plug Ueberauth

  alias CatcastsPhx.{Repo, User}
  alias CatcastsPhxWeb.Router.Helpers

  def create(%{assigns: %{ueberauth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      email: auth.info.email,
      provider: "google"
    }

    changeset = User.changeset(%User{}, user_params)

    case find_or_create_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Thank you for signing in!")
        |> put_session(:user_id, user.id)
        |> redirect(to: Helpers.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: Helpers.page_path(conn, :index))
    end
  end

  defp find_or_create_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end
