class CmsController < ApplicationController
  def not_found_redirect(path)
    flash[:error] = record_not_found
    redirect_to path
  end
end
