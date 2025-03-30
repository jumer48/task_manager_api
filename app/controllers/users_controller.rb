class UsersController < ApplicationController
  def index
    users = User.all
    render json: users  # Or customize the response
  end
end
