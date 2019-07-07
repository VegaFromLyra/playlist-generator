Rails.application.routes.draw do
  post "/spotify/create", to: "spotify_playlist#create"
end
