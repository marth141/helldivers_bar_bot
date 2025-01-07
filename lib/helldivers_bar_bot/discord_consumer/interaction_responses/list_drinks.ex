defmodule HelldiversBarBot.DiscordConsumer.InteractionResponses.ListDrinks do
  @moduledoc """
  Handles listing available drinks in response to a `/list_drinks` command.

  This module defines the `main/1` function, which is responsible for generating a list of drinks and sending it as a Discord interaction response.
  """

  import Bitwise

  alias Nostrum.Api
  alias Nostrum.Struct.ApplicationCommandInteractionData
  alias Nostrum.Struct.Interaction

  @ephemeral_flag 1 <<< 6

  def main(
        %Interaction{
          data: %ApplicationCommandInteractionData{name: "list_drinks"}
        } = msg
      ) do
    list_of_drinks = HelldiversBarBot.Drinks.list_drinks()
    drink_list_payload = build_drink_list_payload(list_of_drinks)

    response = %{
      type: 4,
      data: %{
        content: drink_list_payload,
        flags: @ephemeral_flag
      }
    }

    Api.create_interaction_response(msg, response)
  end

  defp build_drink_list_payload(list_of_drinks) do
    list_of_drinks
    |> Enum.map(fn %HelldiversBarBot.Drinks.Drink{
                     name: drink,
                     description: description,
                     cost: cost
                   } ->
      """
      Drink: #{drink}
      Description: #{description}
      Cost: #{cost}\n
      """
    end)
    |> List.to_string()
  end
end
