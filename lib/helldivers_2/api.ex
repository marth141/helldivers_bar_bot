defmodule Helldivers2.Api do
  @base_url "https://helldiverstrainingmanual.com/api/v1"

  def get_major_orders() do
    with {:ok, %Finch.Response{body: body}} <-
           build_client(:get, "/war/major-orders")
           |> Finch.request(HelldiversBarBot.Finch),
         {:ok, response} <- Jason.decode(body) do
      response
    end
  end

  def get_news() do
    with {:ok, %Finch.Response{body: body}} <-
           build_client(:get, "/war/news")
           |> Finch.request(HelldiversBarBot.Finch),
         {:ok, response} <- Jason.decode(body) do
      response
    end
  end

  defp build_client(method, endpoint) do
    Finch.build(method, "#{@base_url}#{endpoint}")
  end
end
