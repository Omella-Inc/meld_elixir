defmodule Meld.AccountTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe inspect(&Meld.Account.search_by_connection_id/1) do
    test "search accounts be connection id" do
      use_cassette "accounts/search" do
        {:ok, response} = Meld.Account.search_by_connection_id("WQ4tBqDCKpsyHwgBPTAXaR")

        refute response == []
      end
    end
  end

  describe inspect(&Meld.Account.get/1) do
    test "get account by id" do
      use_cassette "accounts/get" do
        {:ok, response} = Meld.Account.get("WQ4tBpyyBoHiaFaezfTe4A")

        refute response == %{}
        refute response["id"] == nil
      end
    end
  end
end
