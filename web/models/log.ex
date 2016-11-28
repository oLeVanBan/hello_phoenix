defmodule HelloPhoenix.Log do
  use HelloPhoenix.Web, :model

  schema "logs" do
    field :a, :integer
    field :b, :integer
    field :c, :integer
    field :result, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:a, :b, :c, :result])
    |> validate_required([:a, :b, :c, :result])
    |> validate_exclusion(:a, [0], message: "a phải khác 0")
  end
end
