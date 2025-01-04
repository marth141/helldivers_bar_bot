defmodule HelldiversBarBot.Commands.ListDrinksTest do
  use ExUnit.Case
  use HelldiversBarBot.DataCase
  use Mimic

  alias HelldiversBarBot.Commands.ListDrink

  describe "add/0" do
    test "successfully adds command to discord bot" do
      application_id = Faker.random_between(1, 9999)

      expect(Nostrum.Cache.Me, :get, fn -> %{id: application_id} end)

      expect(Nostrum.Api, :create_global_application_command, fn outgoing_application_id,
                                                                 command ->
        assert application_id == outgoing_application_id
        assert command.name == "list_drinks"
        assert command.description == "lists drinks"

        {:ok,
         %{
           id: Faker.random_between(1, 9999),
           name: "list_drinks",
           type: 1,
           version: Faker.random_between(1, 9999),
           description: "lists drinks",
           application_id: application_id,
           nsfw: false,
           default_member_permissions: nil,
           dm_permission: true,
           contexts: nil,
           integration_types: [0],
           name_localizations: nil,
           description_localizations: nil
         }}
      end)

      assert {:ok, api_response} = ListDrink.add()
      assert api_response.application_id == application_id
    end
  end
end
