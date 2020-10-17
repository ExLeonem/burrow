defmodule Burrow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application



  # TODO: Needs to be dynamic supervisor
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Burrow.Worker.start_link(arg)
      # {Burrow.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Burrow.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
