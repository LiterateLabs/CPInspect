defmodule CPInspect.MixProject do
  use Mix.Project

  def project do
    [
      app: :cpinspect,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "ColorProcessInspect",
      source_url: "https://github.com/LiterateLabs/ColorProcessInspect",
      homepage_url: "https://github.com/LiterateLabs/ColorProcessInspect",
      docs: [
        main: "ColorProcessInspect",
        extras: ["README.md"],
        authors: ["Jon Crowell", "Abhishek Tripathi"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [ extra_applications: [:logger] ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [ {:ex_doc, "~> 0.28", only: :dev, runtime: false} ]
  end
end
