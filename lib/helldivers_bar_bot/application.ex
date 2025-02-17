defmodule HelldiversBarBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        HelldiversBarBotWeb.Telemetry,
        HelldiversBarBot.Repo,
        {DNSCluster,
         query: Application.get_env(:helldivers_bar_bot, :dns_cluster_query) || :ignore},
        {Phoenix.PubSub, name: HelldiversBarBot.PubSub},
        # Start the Finch HTTP client for sending emails
        {Finch, name: HelldiversBarBot.Finch},
        # Start a worker by calling: HelldiversBarBot.Worker.start_link(arg)
        # {HelldiversBarBot.Worker, arg},
        # Start to serve requests, typically the last entry
        HelldiversBarBotWeb.Endpoint
      ]
      |> maybe_add_discord_consumer()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HelldiversBarBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HelldiversBarBotWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp maybe_add_discord_consumer(children) do
    case Application.get_env(:helldivers_bar_bot, :env) do
      :test -> children
      _anything_else -> children ++ [HelldiversBarBot.DiscordConsumer]
    end
  end
end
