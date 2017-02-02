defmodule HelloPhoenix.User do
  use HelloPhoenix.Web, :model
  use Arc.Ecto.Model


  schema "users" do
    field :user_name, :string
    field :crypted_password, :string
    field :password, :string, virtual: true
    field :avatar, HelloPhoenix.Avatar.Type

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_name, :password, :avatar])
    |> unique_constraint(:user_name)
    |> put_change(:crypted_password, hashed_password(params["password"]))
  end

  defp hashed_password(password) do
    Comeonin.Bcrypt.hashpwsalt(password)
  end
end
