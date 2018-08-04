defmodule CatcastsPhxWeb.PageController do
  use CatcastsPhxWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
