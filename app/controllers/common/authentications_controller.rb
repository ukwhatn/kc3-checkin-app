class Common::AuthenticationsController < ApplicationController
  def new
    AuthMailer.send_auth("ukwhatn@gmail.com", "TOKENTEST").deliver
  end

  def token
  end
end
