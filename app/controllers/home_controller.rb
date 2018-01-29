require 'twitter_api'

class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def search
    tweets = TwitterApi.instance.fetch_tweets_with_params(params[:inputValue].inspect)
    hashtag_map = TwitterApi.instance.populate_hashtag_map(tweets)
    text_array = TwitterApi.instance.fetch_texts_of_tweets(tweets)
    top_ten_arr = []

    hashtag_map.each do |hashtag, count|
      top_ten_arr.push([hashtag, count])
    end
    
    top_ten_arr = top_ten_arr.sort_by { |val| val[1] }.reverse!
    response = {'tweets': text_array, 'hashtags': top_ten_arr[0..9]}
    render status: 200, json: response
  end

end
