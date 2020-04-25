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
    content text 
    )'

     #создает таблицу если она не существует, а если она есть то ничего не происходит 
 @db.execute  'CREATE TABLE if not exists Comments 
  (
    id integer PRIMARY KEY AUTOINCREMENT,
    created_date DATE,
    content text, 
    post_id integer
    )'
end

get '/' do
    #выбираем список постов из БД
  @results = @db.execute 'select * from Posts order by id desc'
   erb :index
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
        #Сохранение данных в ДБ Текс , время и дата 
      @db.execute 'insert into Posts (content, created_date) values (?, datetime());', [@content]

      #перенаправление на главную страницу 
      redirect to '/'   
end  

get '/details/:post_id' do 
  #Получаем переменную из URL
    post_id = params[:post_id]
    #Получаем список постов
    #(У нас будет только один пост)
     results = @db.execute 'select * from Posts where id = ?', [post_id]
     # Выбираем этот один пост в переменную @row
     @row = results[0] 
     # позвращаем представление 
    erb :details
end  
 

 # обработчик пост запроса /deteils/...
 #(браузре отправляет данные на сервер)

post '/deteils/:post_id' do 
    post_id = params[:post_id]
    @content = params[:content]

     @db.execute 'insert into Comments (content, created_date, post_id) values (?, datetime(), ?);', [@content, post_id]


    redirect to('/details/' + post_id) 

end   
