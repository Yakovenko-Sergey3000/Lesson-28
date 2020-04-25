require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
    @db = SQLite3::Datebase.new 'leprosorium.db'
    @db.results_as_hash = true

end

before do 
  
end


get '/' do
   erb "Helloy new projet"
end

get '/new' do 
  erb :new
end 

post '/new' do 
    @content = params[:content]

    erb "You typed #{@content}"
end  

