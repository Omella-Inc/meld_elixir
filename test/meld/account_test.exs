defmodule Meld.AccountTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe inspect(&Meld.Account.start/1) do
    test "search accounts be connection id" do
      use_cassette "accounts/search" do
        {:ok, response} = Meld.Account.search_by_connection_id("WQ4tBqDCKpsyHwgBPTAXaR")

        refute response == []
      end
    end
  end
end
