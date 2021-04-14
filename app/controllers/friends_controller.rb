class FriendsController < ApplicationController
    before_action :set_friend, only: [:show, :create, :destroy]
    before_action :set_user

    def show
        @friends = tweet_for_me.all(user_id: current_user.id) 
    end

    def create
        @user.friends.create(user_id: current_user.id)
        redirect_to root_path  #por que estas conectado  
        
        
        
        # @friend = Friend.new(friend_params.merge(user: current_user))
        
        # respond_to do |format|
        #     if @friend.save
        #         format.html { redirect_to root_path, notice: "Siguiendo" }
        #     else
        #         redirect_to root_path
        #     end
        

        #@user = User.all.find(params[:id])
        #@user.friends.create(user_id: current_user.id, friend_id: @tweet.user.id)
        #Friend.create(user_id: current_user.id, friend_id: @tweet.user.id)
    end

    def destroy
        @friend.destroy
        redirect_to root_path
    end

private
    def set_user
        @user = User.find(params[:user_id])
    end

    def set_friend
        @friend = @user.friends.find(params[:id])
    end

    # def friend_params
    #     params.require(:friend).permit(:friend_id, :user_id)
    # end
  
end
