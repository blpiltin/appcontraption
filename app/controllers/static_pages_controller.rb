class StaticPagesController < ApplicationController
	
  def home
    if signed_in?
      if current_user.admin?
        @users  = User.paginate(page: params[:page])
      else
        @gadgets = current_user.gadgets
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
