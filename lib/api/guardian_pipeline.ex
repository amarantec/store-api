defmodule Api.GuardianPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :api,
    module: Api.Guardian,
    error_handler: Api.GuardianErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug :set_current_user

  defp set_current_user(conn, _) do
    current_user = Guardian.Plug.current_resource(conn)
    assign(conn, :current_user, current_user)
  end
end
