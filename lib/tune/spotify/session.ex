defmodule Tune.Spotify.Session do
  alias Phoenix.PubSub

  @type id :: String.t()
  @type credentials :: Ueberauth.Auth.Credentials.t()

  @callback setup(id(), credentials()) :: :ok | {:error, term()}
  @callback get_profile(id()) :: {:ok, %Tune.User{}} | {:error, term()}
  @callback now_playing(id()) ::
              :not_playing | {:playing, %Tune.Track{} | %Tune.Episode{}} | {:error, term()}

  def subscribe(session_id) do
    PubSub.subscribe(Tune.PubSub, session_id)
  end

  def broadcast(session_id, message) do
    PubSub.broadcast(Tune.PubSub, session_id, message)
  end
end
