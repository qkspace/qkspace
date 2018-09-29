class PrivateController < ApplicationController
  before_action :authenticate_user!

  private

  def public_controller?
    false
  end
end
