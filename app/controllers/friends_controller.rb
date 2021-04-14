class FriendsController < ApplicationController
    before_action :set_friend, only: [:create, :destroy]
    before_action :set_user

    def show
        @friends = tweet_for_me.all(user_id: current_user.id) 
    end

    def create
        @user.friends.create(user_id: current_user.id, friend_id: @tweet.user.id)
        redirect_to root_path, notice: "Siguiendo"

        #@user = User.all.find(params[:id])
        #Friend.create(user_id: current_user.id, friend_id: @tweet.user.id)
    end

    def destroy
        @friend.destroy
        redirect_to root_path
    end

    # private

    def set_user
        @user = User.find(params[:user_id])
    end

    def set_friend
        @friend = @user.friends.find(params[:id])
    end
  
end
