defmodule PlateSlateWeb.Router do
  use PlateSlateWeb, :router

  alias PlateSlateWeb.Plugs.AdminAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PlateSlateWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers, %{"content-security-policy" => "default-src 'self'"}
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug PlateSlateWeb.Plugs.Context
  end

  pipeline :admin_auth do
    plug PlateSlateWeb.Plugs.AdminAuth
  end

  scope "/", PlateSlateWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/admin", PlateSlateWeb do
    pipe_through :browser

    resources "/session", SessionController, only: [:new, :create, :delete], singleton: true
  end

  scope "/admin", PlateSlateWeb do
    pipe_through [:browser, AdminAuth]

    resources "/items", ItemController, only: [:index]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: PlateSlateWeb.Schema, socket: PlateSlateWeb.UserSocket

    forward "/graphiql",
            Absinthe.Plug.GraphiQL,
            schema: PlateSlateWeb.Schema,
            socket: PlateSlateWeb.UserSocket
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PlateSlateWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
