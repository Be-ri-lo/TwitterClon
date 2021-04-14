class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    http_basic_authenticate_with name: "hello", password: "world"
    #before_action :set_api, only: [:show, :update, :destroy]

    def index
        #@tweets = Tweet.pluck(:contet, :user_id, :likes_size, :retweets_size, :retweet_from).map {|data| {content: data.first, user_id: data.second, like_size: data.third, retweets_size: data.fourth, retweet_from: data.fifth}}  #selecciona los campos que quieres que se muestre, ni instancia el resultado
        j_array = []
        Tweet.all.each do |tweet|
            j_array << {
                id: tweet.id,
                content: tweet.content,
                user_id: tweet.user_id,
                likes_size: tweet.likes.size,
                retweet_size: tweet.retweets.size,
                retweet_from: tweet.retweet_id
            }
                
        end
        @tweets = j_array
        render json: @tweets.last(50)
    end

    def show
         @tweets = Tweet.all                  #do something with models #Fuente: https://www.iteramos.com/pregunta/79254/generar-un-informe-por-rango-de-fechas-en-los-largueros
         render json: @tweets.where("DATE(created_at) >= :start_date AND DATE(created_at) <= :end_date", {start_date: params[:start_date], end_date: params[:end_date]})
    end

    def create
        @tweet = Tweet.new(tweet_params)

        if @tweet.save
            render json: @tweet, status: :created, location: @tweet
        else
            render json: @tweet.errors, status: :unprocessable_entity
        end
    end

    def update
        if @api.update(api_params)
            render json: @api
        else
            render json: @api.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @tweet.destroy
    end

    private

    def tweet_params
        params.require(:tweet).permit(:content, :user_id)
    end 
end
