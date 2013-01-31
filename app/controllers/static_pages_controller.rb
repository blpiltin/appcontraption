class StaticPagesController < ApplicationController
	
  def home
    if signed_in?
      if current_user.admin?
        @users  = User.paginate(page: params[:page])
      else
        @apps = current_user.apps.paginate(page: params[:page])
      end
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
