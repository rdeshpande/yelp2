require 'oauth'
require 'json'
require 'pathname'
require 'cgi'

class Yelp
  API_HOST = 'http://api.yelp.com'

  attr_reader :connection

  class ApiError < StandardError; end

  def initialize(params)
    consumer_key = ENV['YELP_CONSUMER_KEY'] || params[:consumer_key]
    consumer_secret = ENV['YELP_CONSUMER_SECRET'] || params[:consumer_secret]
    token = ENV['YELP_TOKEN'] || params[:token]
    token_secret = ENV['YELP_TOKEN_SECRET'] || params[:token_secret]

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, { :site => API_HOST })
    @connection = OAuth::AccessToken.new(consumer, token, token_secret)
  end

  def self.build_query(path, opts)
    "#{path}?#{opts.map { |k,v| "#{k}=#{CGI.escape(v)}" }.join('&')}"
  end
end

dir = Pathname(__FILE__).dirname.expand_path
require dir + 'yelp/search'
