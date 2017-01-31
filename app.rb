require 'sinatra'
require 'data_mapper'
 
DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/data.db")
 
#set :bind, '0.0.0.0'
 class Task
    include DataMapper::Resource
    property :id, Serial
    property :content, String
    property :done, Boolean
end
 
 DataMapper.finalize
DataMapper.auto_upgrade!

  
get '/' do
    
    tasks = Task.all :order => :id.desc
    puts tasks.class
    puts 
    erb :tasks, locals: {:tasks => tasks}
end


post '/add_task' do
   
    task = Task.new
    task.content = params[:task]
    task.done = false
    task.save
    redirect '/'
end
 
post '/toggle_task' do
    
 
    task_id = params[:task_id]
    task = Task.get(task_id)
    task.done = !task.done
    task.save
    redirect '/'
 
end
