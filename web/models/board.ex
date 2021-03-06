defmodule Trelloclone.Board do
  use Trelloclone.Web, :model

  @derive {Poison.Encoder, only: [:id, :name, :user]}

  schema "boards" do
    field :name, :string
    belongs_to :user, Trelloclone.User

    has_many :user_boards, UserBoard
    has_many :members, through: [:user_boards, :user]

    timestamps()
  end

  @required_fields ~w(name user_id)
  @optional_fields ~w()

  def preload_all(query) do
    from b in query, preload: [:user, :members]
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end
end
