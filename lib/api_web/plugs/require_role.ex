defmodule ApiWeb.Plugs.RequireRole do
	@behaviour Plug
	import Plug.Conn
	import Phoenix.Controller, only: [json: 2]
	
	alias Api.Accounts
	alias Api.Accounts.User
	alias Api.Guardian
	
	def init(opts), do: opts
	
	def call(conn, opts) do
		roles = Keyword.get(opts, :roles, Keyword.get(opts, :role)) |> List.wrap()
		current_resource = Guardian.Plug.current_resource(conn)
		
		with %Api.Accounts.User{role: user_role} <- current_resource, true <- Enum.member?(roles, user_role) do
			conn
		else
			_ ->
				conn
				|> put_status(:forbidden)
				|> json(%{
					error: "Access denied, insufficient permissions.",
					message: "Required one of: #{Enum.join(roles, ", ")}",
					your_role: current_resource && current_resource.role})
				|> halt()
		end
	end
end
