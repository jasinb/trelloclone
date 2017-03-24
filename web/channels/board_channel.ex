defmodule Trelloclone.BoardChannel do
  use Trelloclone.Web, :channel
  alias Trelloclone.{User, UserBoard}

  def join("boards:" <> board_id, _params, socket) do
    board = get_current_board(socket, board_id)

    {:ok, %{board: board}, assign(socket, :board, board)}
  end

  defp get_current_board(socket, board_id) do
    socket.assigns.current_user
    |> assoc(:boards)
    |> Repo.get(board_id)
  end

  def handle_in("members:add", %{"email" => email}, socket) do
    try do
      board = socket.assigns.board
      user = Repo.get_by(User, email: email)

      changeset = user
      |> build_assoc(:user_boards)
      |> UserBoard.changeset(%{board_id: board.id})

      case Repo.insert(changeset) do
        {:ok, _board_user} ->
          broadcast! socket, "member:added", %{user: user}

          Trelloclone.Endpoint.broadcast_from! self(), "users:#{user.id}", "boards:add", %{board: board}
          {:noreply, socket}
        
        {:error, _changeset} ->
          {:reply, {:error, %{error: "Error adding new member"}}, socket }
      end
    catch
      _, _ -> {:reply, {:error, %{error: "User does not exist"}}, socket }
    end
  end
end
