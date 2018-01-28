require 'twitter_api'

class HomeController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end
  def search
    tweets = TwitterApi.instance.fetchTweetsWithParams(params[:inputValue].inspect)
    hashtagMap = TwitterApi.instance.populateHashtagMap(tweets)
    textArray = TwitterApi.instance.fetchTextsOfTweets(tweets)
    topTenArr = []
    hashtagMap.each do |hashtag, count|
      topTenArr.push([hashtag, count])
    end
    topTenArr.sort_by { |val| val[1] }.reverse!
    response = {'tweets': textArray, 'hashtags': topTenArr[0..9]}
    render status: 200, json: response

  end
end
