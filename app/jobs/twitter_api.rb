require 'twitter'

class TwitterApi
  def initialize
    @client = Twitter::REST::Client.new do |config|
      # Will set these as environment variables later, it is a dummy account so no problem in revealing the details
      config.consumer_key        = 'HcsgBfYNZSnlNfgsbUnNHAGsi'
      config.consumer_secret     = '22HO1U79YNChhmNz8Fbz6wUgQp5AiDCdhwodwehwSOJOXhWiu7'
      config.access_token        = '957180756543107072-stTjIPqiz0DCmciAdOYuzyY1u01i30p'
      config.access_token_secret = 'pesRuhPcehTfUieyW88TECwXyeus7pkZbpZ2s7lC9utZi'
    end
  end

  @@instance = TwitterApi.new

  def self.instance
    return @@instance
  end

  def populate_hashtag_map(tweets)
    complete_hashtag_map = {}
    tweets.each do |tweet|
      entities = tweet[:entities]
      unless entities.nil?
        hashtags = entities[:hashtags]
        unless hashtags.empty?
          hashtags.each do |hashtag|
            hashtag_text = hashtag[:text]
            complete_hashtag_map[hashtag_text] = if complete_hashtag_map.key?(hashtag_text)
              complete_hashtag_map[hashtag_text] + 1
            else
              1
            end
          end
        end
      end
    end
    complete_hashtag_map
  end

  def fetch_texts_of_tweets(tweets)
    text_array = []
    tweets.each do |tweet|
      text_array.push(tweet[:text])
    end
    text_array
  end

  def fetch_tweets_with_params(params)
    options = {result_type: 'mixed', count: 100}
    result = @client.search(params, options)
    result.attrs[:statuses]
  end

  private_class_method :new
end
