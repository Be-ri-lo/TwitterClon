class HomesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to tweets_path(@tweets)
      end
  end
end
