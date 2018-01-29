require 'twitter'

class TwitterApi
  def initialize
    @client = Twitter::REST::Client.new do |config|
      # Will set these as environment variables later, it is a dummy account so no problem in revealing the details
      config.consumer_key        = "HcsgBfYNZSnlNfgsbUnNHAGsi"
      config.consumer_secret     = "22HO1U79YNChhmNz8Fbz6wUgQp5AiDCdhwodwehwSOJOXhWiu7"
      config.access_token        = "957180756543107072-stTjIPqiz0DCmciAdOYuzyY1u01i30p"
      config.access_token_secret = "pesRuhPcehTfUieyW88TECwXyeus7pkZbpZ2s7lC9utZi"
    end
  end

  @@instance = TwitterApi.new

  def self.instance
    return @@instance
  end

  def populateHashtagMap(tweets)
    completeHashtagMap = {}
    tweets.each do |tweet|
      unless tweet[:entities].nil?
        unless tweet[:entities][:hashtags].empty?
          tweet[:entities][:hashtags].each do |hashtag|
            if completeHashtagMap.key?(hashtag[:text])
              completeHashtagMap[hashtag[:text]] = completeHashtagMap[hashtag[:text]] + 1
            else
              completeHashtagMap[hashtag[:text]] = 1
            end
          end
        end
      end
    end
    completeHashtagMap
  end

  def fetchTextsOfTweets(tweets)
    textArray = []
    tweets.each do |tweet|
      textArray.push(tweet[:text])
    end
    textArray
  end

  def fetchTweetsWithParams(params)
    options = {:result_type => "mixed", :count => 100}
    result = @client.search(params, options)
    puts result.attrs[:statuses].length
    result.attrs[:statuses]
  end

  private_class_method :new
end
