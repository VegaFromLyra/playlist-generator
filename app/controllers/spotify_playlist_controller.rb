class SpotifyPlaylistController < ApplicationController
  include SlackSignature

  protect_from_forgery

  def create
    if authenticated?
      response = {
        text: "We are hard at work.."
      }

      render json: response, status: 201
    else
      response = {
        text: "The request signature is not valid"
      }

      render json: response, status: 401
    end
  end
end
