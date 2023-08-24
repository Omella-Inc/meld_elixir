defmodule Meld.Connect do
  @endpoint "bank-linking/connect"

  @type connect_params :: %{
          required(:externalCustomerId) => String.t(),
          required(:products) => list(String.t()),
          optional(:regions) => list(String.t()),
          optional(:allowRedirect) => boolean()
        }

  @type connect_response :: %{
          id: String.t(),
          connectToken: String.t(),
          customerId: String.t(),
          externalCustomerId: String.t(),
          widgetUrl: String.t()
        }

  @spec start(connect_params, Keyword.t()) :: {:ok, connect_response()} | {:error, map()}
  def start(params, header_opts \\ []) do
    Meld.make_request(:post, "#{@endpoint}/start", params, header_opts)
  end
end
