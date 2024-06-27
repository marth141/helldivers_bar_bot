# Helldivers Bar Bot

# Overview

This bot was built for the 606th community by Kerobero's using a standard simple Elixir stack. See infrastructure to learn more.
# Features

## Slash Commands

* /balance - To check your balance
	* To see how much you have in your "wallet" for drinks. The currency has no particular unit or any real world value.
* /buy_drink \<drink\> \<user\>
	* To buy a user a drink. There are auto completions for drinks and users and you can pick from the list.

## Frontend Interface

This would be some webpages where someone can configure the bot a bit. They're pretty barebones. While the bot is working on a Raspberry Pi in Kerobero's bedroom, the webpages will be unavailable.

## Currency

When a user sends a message on the server, the bot will add 0.25 to their wallet. This currency has no real value other than to buy drinks and the economy given by activity in the server.

The bot will only accrue currency by observing channels that it is. It'll automatically be in any public channel. If you are in a channel and don't see it in the user list, then it is not in that channel.
# Feedback

Tag Kerobero in \#danger-close with any feedback and he can get it worked on

# Infrastructure

This application is currently running on a Raspberry Pi 5 computer in Kerobero's bedroom. It may have outages but he'll do his best to keep it running. For more stability, it should be installed onto a cloud computer provided by digitalocean which can cost around $4 per month. If an outage does occur, please tag Kerobero with details about what is happening.

The application itself was built using a standard Elixir & Phoenix stack which includes
- <a href="https://elixir-lang.org/">Elixir - The core language, like python.</a>
- <a href="https://www.phoenixframework.org/">Phoenix - The website server which provides the html pages</a>
- <a href="https://hexdocs.pm/ecto/Ecto.html">Ecto - An Elixir interface with PostgreSQL</a>
- <a href="https://www.postgresql.org/">PostgreSQL - A standard SQL database</a>

All of which is free and open source technology. If anyone has any interest to develop for it, please have them reach out to Kerobero.

The code is currently hosted on GitHub at the link below,
https://github.com/marth141/helldivers_bar_bot

# To start Phoenix Server

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
