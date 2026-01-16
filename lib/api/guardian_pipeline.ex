defmodule Api.GuardianPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :api,
     module: Api.Guardian,
    error_handler: Api.GuardianErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
