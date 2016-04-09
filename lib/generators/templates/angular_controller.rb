##
#  Angular controller for securing html templates

class AngularController < ApplicationController
  before_filter :authenticate_user!

  def show
    send_file "#{Rails.root}/angular/#{params['a']}.#{params['format']}"
  end

end