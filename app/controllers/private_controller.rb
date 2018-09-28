class PrivateController < ApplicationController
  before_action :check_domain
  before_action :authenticate_user!

  private

  def public_controller?
    false
  end

  def check_domain
    unless request.env['qkspace.area'][:kind] == :private
      redirect_to root_url, host: request_env['qkspace.area'][:private_domain]
    end
  end
end
