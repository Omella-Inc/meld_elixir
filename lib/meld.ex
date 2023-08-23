defmodule Meld do
  use HTTPoison.Base

  @live_url "https://api.meld.io/"
  @sandbox_url "https://api-sb.meld.io/"

  def process_url(endpoint) do
    api_url()
    |> URI.parse()
    |> URI.to_string()
    |> Kernel.<>(endpoint)
  end

  def process_request_headers(_opts) do
    [
      {"Content-Type", "application/json;charset=UTF-8"},
      {"Authorization", "Basic #{get_credentials()}"}
    ]
  end

  def process_request_body(body) do
    Jason.encode!(body)
  end

  def process_response_body(body) do
    body
    |> Jason.decode()
    |> case do
      {:ok, data} -> data
      {:error, _} -> {:error, body}
    end
  end

  def make_request(method, endpoint, body \\ "", headers \\ [], options \\ []) do
    options =
      options
      |> Keyword.put(:recv_timeout, 30_000)
      |> Keyword.put(:ssl, [{:versions, [:"tlsv1.2", :"tlsv1.3", :"tlsv1.1", :tlsv1]}])

    case request(method, endpoint, body, headers, options) do
      {:error, _} = err -> err
      {:ok, response} -> handle_response(response)
    end
  end

  defp get_credentials() do
    Application.get_env(:meld_elixir, :meld_credentials, System.get_env("MELD_CREDENTIALS"))
  end

  defp api_url do
    if Application.get_env(:meld_elixir, :sandbox, false) do
      @sandbox_url
    else
      @live_url
    end
  end

  defp handle_response(response) do
    case response.status_code do
      200 -> {:ok, response.body}
      201 -> {:ok, response.body}
      202 -> {:ok, response.body}
      204 -> {:ok, response.body}
      400 -> {:error, response.body}
      401 -> {:error, :unauthorized}
      404 -> {:error, :not_found}
      422 -> {:error, response.body}
    end
  end
end
