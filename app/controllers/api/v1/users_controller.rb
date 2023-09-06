class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :require_api_key

  def index
    users = User.all.joins(:univ, :group).pluck(
      "users.id",
      "users.email",
      "users.last_name",
      "users.first_name",
      "univs.name", "groups.name"
    )
    render json: users
  end
end
