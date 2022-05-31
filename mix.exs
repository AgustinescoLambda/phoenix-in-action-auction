defmodule AuctionUmbrella.MixProject do
  use Mix.Project

  def project do
    [
      name: "Auction web",
      apps_path: "apps",
      version: "0.1.0",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:ecto_sql , "~> 3.8.2"},
      {:postgrex, "~> 0.16.3"},
      {:ex_doc, "~> 0.19", dev: true, runtime: false}
    ]
  end
end
