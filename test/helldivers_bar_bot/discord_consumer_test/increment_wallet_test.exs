defmodule HelldiversBarBot.DiscordConsumerTest.IncrementWalletTest do
  use ExUnit.Case
  use HelldiversBarBot.DataCase

  alias HelldiversBarBot.DiscordConsumer.IncrementWallet
  alias HelldiversBarBot.Helldivers
  alias HelldiversBarBot.Helldivers.Helldiver

  describe "main/1" do
    setup do
      {:ok, helldiver} =
        Helldivers.create_helldiver(%{
          name: Faker.Person.name(),
          discord_id: Faker.UUID.v4(),
          messages_sent: Faker.Random.Elixir.random_between(0, 1000),
          wallet: Decimal.new("1000")
        })

      %{helldiver: helldiver}
    end

    test "Successfully updates Helldiver", %{helldiver: %Helldiver{} = helldiver} do
      {:ok, %Helldiver{} = updated_helldiver} = IncrementWallet.main(helldiver.discord_id)

      assert updated_helldiver.wallet == Decimal.new("1000.25")
    end
  end
end
