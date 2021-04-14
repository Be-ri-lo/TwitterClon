class TweetsController < ApplicationController
    before_action :set_tweet, only: [ :show, :edit, :update, :destroy ]
    before_action :set_current_tweet, only:[:like, :retweet]
    before_action :authenticate_user! #except: [:index, :show]
    
    # GET /tweets or /tweets.json
    def index
      @q = Tweet.page(params[:page]).ransack(params[:q])
      @tweets = @q.result(distinct: true)
      @tweet = Tweet.new
    end
     
  
    # GET /tweets/1 or /tweets/1.json
    def show
      @tweets = Tweet.all
      #@retweet = Tweet.find_by(id: @tweet.tweet_id)
    end
  
    # GET /tweets/new
    def new 
      @tweet = current_user.tweets.build
    end
  
    # GET /tweets/1/edit
    def edit
    end
  
    # POST /tweets or /tweets.json
    def create
      @tweet = Tweet.new(tweet_params.merge(user: current_user))  #para llamar al usuario conectado
  
      respond_to do |format|
        if @tweet.save
          format.html { redirect_to root_path, notice: "Tweet was successfully created." }
          format.json { render :show, status: :created, location: @tweet }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @tweet.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /tweets/1 or /tweets/1.json
    def update
      respond_to do |format|
        if @tweet.update(tweet_params)
          format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
          format.json { render :show, status: :ok, location: @tweet }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @tweet.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /tweets/1 or /tweets/1.json
    def destroy
      @tweet.destroy
      respond_to do |format|
        format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    # like
    def like
      @tweet = Tweet.all.find(params[:id])
      Like.create(user_id: current_user.id, tweet_id: @tweet.id)
      redirect_to tweet_path(@tweet)
    end 
  
    def unlike    #arreglar
      @tweet = Tweet.all.find(params[:id])
      Like.destroy(user_id: current_user.id, tweet_id: @tweet.id)
      redirect_to tweet_path(@tweet)
    end
  
    # Retweet
    def retweet
      if @tweet
        Tweet.create(user_id: current_user.id, content: "Este Tweet pertenece a: #{@tweet.user.name}: #{@tweet.content}", retweet_id: @tweet.id)
        redirect_to root_path, notice: "Was Retweet!"
      end
      #version choca con callback
      # if @tweet
      #   @tweet = Tweet.new(tweet_params.merge(user: current_user))
      # redirect_to new_tweet_path(tweet) #pendiente de la vista, no resulta.  
      # end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tweet
        @tweet = Tweet.find(params[:id])
      end
  
      def set_current_tweet
        @tweet = Tweet.find(params[:tweet_id])
      end
  
      # Only allow a list of trusted parameters through.
      def tweet_params
        params.require(:tweet).permit(:content, :user_id)
      end
  
  
       
  end
  
