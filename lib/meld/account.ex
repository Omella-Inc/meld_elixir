defmodule Meld.Account do
  @endpoint "bank-linking/accounts"

  @spec search_by_connection_id(String.t(), Keyword.t()) :: {:ok, map()} | {:error, map()}
  def search_by_connection_id(connection_id, header_opts \\ []) do
    Meld.make_request(:get, "#{@endpoint}?connectionId=#{connection_id}", header_opts)
  end
end
