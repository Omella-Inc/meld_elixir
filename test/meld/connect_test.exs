defmodule Meld.ConnectionTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  describe inspect(&Meld.Connect.start/1) do
    test "creates a connection" do
      use_cassette "connection/start" do
        {:ok, response} =
          Meld.Connect.start(%{
            externalCustomerId: "user@domain.com",
            products: ["BALANCES", "OWNERS"]
          })

        refute response == %{}
        refute response["id"] == nil
      end
    end
  end
end
