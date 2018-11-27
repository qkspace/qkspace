class PrivateController < ApplicationController
  before_action :require_user!

  private

  def public_controller?
    false
  end
end
