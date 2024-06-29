defmodule HelldiversBarBot.Helldivers do
  @moduledoc """
  The Helldivers context.
  """

  import Ecto.Query, warn: false
  alias HelldiversBarBot.Repo
  alias HelldiversBarBot.Helldivers.Helldiver

  @doc """
  Returns the list of Helldivers.

  ## Examples

      iex> list_helldivers()
      [%Helldiver{}, ...]

  """
  def list_helldivers do
    Repo.all(Helldiver)
  end

  @doc """
  Gets a single helldiver.

  Raises `Ecto.NoResultsError` if the Helldiver does not exist.

  ## Examples

      iex> get_helldiver!(123)
      %Helldiver{}

      iex> get_helldiver!(456)
      ** (Ecto.NoResultsError)

  """
  def get_helldiver!(id), do: Repo.get!(Helldiver, id)

  @spec get_helldiver_by_discord_id(String.t()) :: %Helldiver{} | nil
  def get_helldiver_by_discord_id(discord_id),
    do: Repo.get_by(Helldiver, discord_id: discord_id)

  @doc """
  Creates a helldiver.

  ## Examples

      iex> create_helldiver(%{field: value})
      {:ok, %Helldiver{}}

      iex> create_helldiver(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_helldiver(%Nostrum.Struct.Guild.Member{user_id: discord_id, nick: name}) do
    %Helldiver{}
    |> Helldiver.changeset(%{"discord_id" => to_string(discord_id), "name" => name})
    |> Repo.insert()
  end

  def create_helldiver(%Nostrum.Struct.User{id: discord_id, username: name}) do
    %Helldiver{}
    |> Helldiver.changeset(%{"discord_id" => to_string(discord_id), "name" => name})
    |> Repo.insert()
  end

  def create_helldiver(attrs) do
    %Helldiver{}
    |> Helldiver.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a helldiver.

  ## Examples

      iex> update_helldiver(helldiver, %{field: new_value})
      {:ok, %Helldiver{}}

      iex> update_helldiver(helldiver, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_helldiver(%Helldiver{} = helldiver, attrs) do
    helldiver
    |> Helldiver.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a helldiver.

  ## Examples

      iex> delete_helldiver(helldiver)
      {:ok, %Helldiver{}}

      iex> delete_helldiver(helldiver)
      {:error, %Ecto.Changeset{}}

  """
  def delete_helldiver(%Helldiver{} = helldiver) do
    Repo.delete(helldiver)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking helldiver changes.

  ## Examples

      iex> change_helldiver(helldiver)
      %Ecto.Changeset{data: %Helldiver{}}

  """
  def change_helldiver(%Helldiver{} = helldiver, attrs \\ %{}) do
    Helldiver.changeset(helldiver, attrs)
  end
end
