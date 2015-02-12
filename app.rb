require 'sinatra'
require 'sinatra/reloader'
require "better_errors"
require 'pry'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

quotes = []
id = 1

get '/' do
  @quotes = quotes
  erb :index
end

get '/quotes/new' do
  erb :new
end

post '/quotes' do
  quote = {}
  quote[:id] = id
  quote[:x] = params[:quote]
  id += 1
  quotes << quote
  redirect '/'
end

get '/quotes/:id' do
  quotes.each do |quote|
    if(params[:id].to_i == quote[:id])
      @quote = quote
    end
  end
  erb :edit
end

put '/quotes/:id' do
  quotes.each do |quote|
    if (params[:id].to_i == quote[:id])
      quote[:x] = params[:quote]
      @quote = quote
    end
  end
  redirect '/'
end


delete '/quotes/:id' do
  quotes.each_with_index do |quote, index|
    if(params[:id].to_i == quote[:id])
      quotes.delete_at(index)
    end
  end
  redirect '/'
end

