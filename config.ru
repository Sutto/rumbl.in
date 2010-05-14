require 'rubygems'
require 'sinatra'

COMPETITION_DOMAIN = "r09.railsrumble.com"

set :environment, ENV['RACK_ENV']

helpers do

  def convert_query(path)
    p = [*path].join("/").split("/")
    URI.escape(p.map { |t| t.gsub(/[\+\-]+/, " ").gsub(/[\?\#\&]+/, ' ') }.join(" ").strip)
  end

end

get '/g/:team_name' do
  redirect "http://#{COMPETITION_DOMAIN}/teams/#{params[:team_name]}"
end

get '*' do
  path = convert_query(params[:splat])
  redirect "http://#{COMPETITION_DOMAIN}/teams/search?q=#{path}"
end

run Sinatra::Application
