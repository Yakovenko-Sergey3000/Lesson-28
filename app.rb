require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
    @db = SQLite3::Database.new 'leprosorium.db'
    @db.results_as_hash = true

end

before do 
  init_db
end

configure do 
  init_db
 @db.execute  'CREATE TABLE if not exists Posts 
  (
    id integer PRIMARY KEY AUTOINCREMENT,
    created_date DATE,
    content text UNIQUE
    )'
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

