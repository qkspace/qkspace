class PrivateController < ApplicationController
  before_action :set_locale_for_user
  before_action :require_user!

  private

  def public_controller?
    false
  end
end
