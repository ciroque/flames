defmodule Flames.Error do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, except: [:__meta__]}

  schema "errors" do
    field :message, :string
    field :level, :string
    field :timestamp, Ecto.DateTime
    field :alive, :boolean
    field :module, :string
    field :function, :string
    field :file, :string
    field :line, :integer
    field :count, :integer
    field :hash, :string

    timestamps
  end

  @required ~w(message timestamp alive hash count level)
  @optional ~w(module function file line)

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required, @optional)
  end

  def reported?(hash) when is_binary(hash) do
    import Ecto.Query
    from e in __MODULE__,
      where: e.hash == ^hash,
      limit: 1,
      select: true
  end
end
