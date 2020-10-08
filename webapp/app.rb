#!/usr/bin/env ruby

require "sinatra"
require "sinatra/cookies"
require "kramdown"


configure do
  # Note: Inline templates automagically loaded in the file that requires sinatra (apparently not)
  enable :inline_templates
  enable :sessions
end

set :environment, :development

class Alert
  attr_accessor(:level, :message)
  def initialize(level, message)
    @level = level
    @message = message
  end
end


get '/' do
  slim :index
end

get '/register/?' do
  slim :register
end

post '/fan/new/?' do
  #session[:name] = params[:name]
  session.update(params)
  session[:alerts] = [Alert.new('warning', 'WIP'), Alert.new('info', "session #{session.class} = #{session.inspect}"), Alert.new('info', "params #{params.class} = #{params}")]
  redirect to('/')
end

get '/logout' do
  session.delete(:identity)
  session[:alerts] = [Alert.new('info', 'You have been logged out')]
  redirect to('/')
end

get '/alerts' do
  slim '| alerts = #{session[:alerts].inspect}'
end

not_found do
  session[:alerts] = [Alert.new('danager', 'These are not the droids you are looking for')]
  slim :index
end

__END__

@@ layout
doctype html
html
  head
    title BJTM Fan Club
    link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" type="text/css" crossorigin="anonymous" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
  body
    .jumbotron class="text-center"
      h1 BJTM Fan Club
    - if @alerts
      - @alerts.each do |item|
        .alert class="alert-#{item.level}" #{item.message}
    == yield


@@ index
#content
  h1 Welcome to the BJTM Fan Club
  - if session[:name]
    - if session[:admin]
      .alert class="alert-success" Anton will do the secret meet and greet, the password to get backstage is #{ENV['FLAG']}
    p = "how you doin' #{session[:name]}"
    markdown:
      [Logout](logout)
  - else
    markdown:
      [Register](register) if you're a fan

@@ register
  h1 Register
  form action="fan/new" method="post"
    label for="name" Name:
    input type="text" name="name" id="name"
    input type="submit" class="btn btn-primary"


