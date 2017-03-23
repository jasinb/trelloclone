defmodule Trelloclone.PageController do
  use Trelloclone.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
