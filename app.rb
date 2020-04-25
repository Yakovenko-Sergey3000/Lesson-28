require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
    @db = SQLite3::Database.new 'leprosorium.db'
    @db.results_as_hash = true

end

before do 
  #инициализация БД
  init_db
end

# configure - Вызывается каждый раз при конфигурации приожения:
# когда изменяется код прграммы и перезрузилась страница
configure do 
  init_db
  #создает таблицу если она не существует, а если она есть то ничего не происходит 
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

      if @content.size <= 0 
         @error = "Type post text "
         return erb :new 
      end  
    erb "You typed #{@content}"
end  

