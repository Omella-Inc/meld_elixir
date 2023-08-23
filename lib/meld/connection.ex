defmodule Meld.Connection do

  @endpoint "bank-linking/connect"

  @type connect_params :: %{
    required(:externalCustomerId) => String.t(),
    required(:products) => list(String.t()),
    optional(:regions) => list(String.t()),
    optional(:allowRedirect) => boolean()
  }

  @spec start(connect_params, Keyword.t()) :: {:ok, map()} | {:error, map()}
  def start(params, header_opts \\ []) do
    Meld.make_request(:post, "#{@endpoint}/start", params, header_opts)
  end

end
