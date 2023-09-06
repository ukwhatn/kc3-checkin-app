class Api::V1::AuthorizationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_api_key, only: [:destroy]

  def create
    token = params[:token]
    unless token.present? && token == ENV["API_TOKEN"]
      render json: { message: "Invalid token" }, status: :unauthorized
      return
    end

    key = ApiKey.create_token
    if key
      render json: { key: key.key_string }, status: :created
    else
      render json: { message: "Something went wrong" }, status: :internal_server_error
    end
  end

  def destroy
    key = get_api_key
    if key.present?
      key.destroy
      render json: { message: "Token deleted" }, status: :ok
    else
      render json: { message: "Invalid token" }, status: :unauthorized
    end
  end
end
