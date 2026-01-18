defmodule ApiWeb.Router do
  use ApiWeb, :router

	@admin_role "admin"
	@customer_role "customer"
	@roles %{
		admin: "admin",
		user: ["customer", "admin"]
	}
  pipeline :api do
    plug :accepts, ["json"]
  end
  
  pipeline :admin do
  	plug :api
  	plug Api.GuardianPipeline
  	plug ApiWeb.Plugs.RequireRole, role: @roles.admin
  end
  
  pipeline :user do
		plug :api
  	plug Api.GuardianPipeline
  	plug ApiWeb.Plugs.RequireRole, roles: @roles.user

  end

	## Public Routes
  scope "/api", ApiWeb do
    pipe_through :api
    post "/accounts/register", UserController, :create
    post "/accounts/sign_in", UserController, :sign_in
    patch "/accounts/reset_password", UserController, :reset_password
    
    ## Public Read (no auth)
    resources "/categories", CategoryController, only: [:index, :show]
    resources "/products", ProductController, only: [:index, :show]
  end

	## Routes for authenticated customers
  scope "/api", ApiWeb do
  	pipe_through [:user]
   	resources "/addresses", AddressController
  end
  
  ## Routes for admin only
  scope "/api", ApiWeb do
    pipe_through [:admin]
  	resources "/categories", CategoryController
  	resources "/products", ProductController
  	resources "/accounts", UserController
   	resources "/addresses", AddressController
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
