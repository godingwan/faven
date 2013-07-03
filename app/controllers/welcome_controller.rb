class WelcomeController < ApplicationController
  respond_to :html

  def index
    # occasionally the redirect to root path returns
    # a status code of 304 (Not Modified) which causes
    # the page to display a not signed in page when
    # actually signed in or vice-versa. This is an
    # attempt to addres that issue.
    # More info @
    # http://archives.ryandaigle.com/articles/2009/8/6/what-s-new-in-edge-rails-cleaner-restful-controllers-w-respond_with/
    if current_user
      respond_with current_user
    end
  end
end
