if Code.ensure_loaded?(Phoenix.Router) do
  defmodule Flames.Router do
    @moduledoc """
    """

    use Phoenix.Router

    def static_path(%Plug.Conn{script_name: script}, path), do: Path.join(script, "/") <> path

    pipeline :browser do
      plug :accepts, ~w(html)
    end

    pipeline :api do
      plug :accepts, ["json"]
    end

    scope "/", Flames do
      pipe_through :browser

      get "/", ErrorsController, :interface
    end

    scope "/api", Flames do
      pipe_through :api

      get "/errors", ErrorsController, :index
      get "/errors/:id", ErrorsController, :show
    end
  end
end