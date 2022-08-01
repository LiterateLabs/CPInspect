defmodule CPInspect.MixProject do
  use Mix.Project

  def project do
    [
      app: :color_process_inspect,
      version: "0.1.0",
      elixir: "~> 1.14.0-rc.0",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "ColorProcessInspect",
      source_url: "https://github.com/LiterateLabs/ColorProcessInspect",
      homepage_url: "https://github.com/LiterateLabs/ColorProcessInspect",
      description: description(),
      package: package(),
      docs: [
        main: "ColorProcessInspect",
        extras: ["README.md"],
        authors: ["Jon Crowell", "Abhishek Tripathi"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [extra_applications: [:logger]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:ex_doc, "~> 0.28", only: :dev, runtime: false}]
  end

  defp description do
    """
    Library for development and debugging that provides color-coded inspect
    output according the the process (pid) that is doing the inspecting.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Jon Crowell"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/LiterateLabs/ColorProcessInspect"}
    ]
  end
end
