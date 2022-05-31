defmodule AuctionWeb.GlobalHelpers do
  use Timex

  def integer_to_dollar(cents) do
    dollar_and_cent=
      cents
        |>  Decimal.div(100)
        |>  Decimal.round(2)
    "$ #{dollar_and_cent}"
  end

  def formatted_datetime(datetime) do
    datetime
      |>  Timex.format!("{YYYY}-{0M}-{0D} {h12}:{m}:{s} {am}")
  end

end
