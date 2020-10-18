defmodule Burrow.MixProject do
  use Mix.Project

  def project do
    [
      app: :burrow,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Burrow.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.7"},
      {:floki, "~> 0.29.0"},
      {:fast_html, "~> 2.0"},
      {:ex_doc, "~> 0.22.6", only: :dev},
      {:excoveralls, "~> 0.13.2", only: :test},
      {:bypass, "~> 2.0", only: :test},
      {:plug_cowboy, "~> 1.0", only: :test}      
    ]
  end
end
