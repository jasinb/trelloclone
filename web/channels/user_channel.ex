defmodule Trelloclone.UserChannel do
  use Trelloclone.Web, :channel

  def join("users:" <> user_id, _params, socket) do
    {:ok, socket}
  end
end
