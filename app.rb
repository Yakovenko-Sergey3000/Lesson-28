require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
   erb "Helloy new projet"
end

get '/new' do 
  erb :new
end 

