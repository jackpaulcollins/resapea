class ApplicationController < ActionController::Base
  include CurrentUserConcern

  skip_before_action :verify_authenticity_token
  before_action :set_current_user

  def current_user
    set_current_user
  end

  def fallback_index_html
    render :file => 'public/index.html'
  end
end
