import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :auction_web, AuctionWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "exhPG4o5cvHmSJhdyRd6iQursOtv3tYrCWf5WWkVNDAqQC/qrek41vS3BOQxfuSn",
  server: false

config :auction, Auction.Repo,
  database: "auction_test",
  username: "agustinesco",
  password: "",
  hostname: "localhost",
  port: "5432",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger , level: :info
