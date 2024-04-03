defmodule HelldiversBarBot.Quips do
  @moduledoc """
  The Quips context.
  """

  import Ecto.Query, warn: false
  alias HelldiversBarBot.Repo

  alias HelldiversBarBot.Quips.Quip

  @doc """
  Returns the list of quips.

  ## Examples

      iex> list_quips()
      [%Quip{}, ...]

  """
  def list_quips do
    Repo.all(Quip)
  end

  @doc """
  Gets a single quip.

  Raises `Ecto.NoResultsError` if the Quip does not exist.

  ## Examples

      iex> get_quip!(123)
      %Quip{}

      iex> get_quip!(456)
      ** (Ecto.NoResultsError)

  """
  def get_quip!(id), do: Repo.get!(Quip, id)

  @doc """
  Creates a quip.

  ## Examples

      iex> create_quip(%{field: value})
      {:ok, %Quip{}}

      iex> create_quip(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_quip(attrs \\ %{}) do
    %Quip{}
    |> Quip.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a quip.

  ## Examples

      iex> update_quip(quip, %{field: new_value})
      {:ok, %Quip{}}

      iex> update_quip(quip, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_quip(%Quip{} = quip, attrs) do
    quip
    |> Quip.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a quip.

  ## Examples

      iex> delete_quip(quip)
      {:ok, %Quip{}}

      iex> delete_quip(quip)
      {:error, %Ecto.Changeset{}}

  """
  def delete_quip(%Quip{} = quip) do
    Repo.delete(quip)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking quip changes.

  ## Examples

      iex> change_quip(quip)
      %Ecto.Changeset{data: %Quip{}}

  """
  def change_quip(%Quip{} = quip, attrs \\ %{}) do
    Quip.changeset(quip, attrs)
  end
end
