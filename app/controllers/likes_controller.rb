class LikesController < ApplicationController
  before_action :set_like, only: [:destroy]
  before_action :set_tweet

  def show
    @likes = tweet_like.all(user_id: current_user.id)
  end

  def create
    @tweet.likes.create(user_id: current_user.id)
    redirect_to root_path  #por que estas conectado  
  end

  def destroy
    @like.destroy
    redirect_to root_path
  end

# private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def set_like
    @like = @tweet.likes.find(params[:id])
  end
end
