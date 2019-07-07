class SpotifyPlaylistController < ApplicationController
  protect_from_forgery

  before_action :verify_signature

  def create
    response = {
      text: "We are hard at work.."
    }

    render json: response, status: 201
  end

  def verify_signature
    # TODO: Implement Slack's signed signature verification
    # https://api.slack.com/docs/verifying-requests-from-slack
  end
end
