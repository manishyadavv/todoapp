require 'sinatra'
 
set :bind, '0.0.0.0'
class Task
    attr_reader :task, :completed, :id
    def initialize task, id
        @task = task
        @completed = false
        @id = id
    end
 
    def toggle_task
        @completed = !@completed
    end
 
    def to_s
        "Task: #{@task}, Completed: #{@completed}"
    end
 
end
 
 
tasks = []
unique_id = 0
 
 
get '/' do
    puts tasks
    erb :tasks, locals: {:tasks => tasks, :time => Time.now}
end
post '/add_task' do
    unique_id = unique_id + 1
    task = Task.new params[:task], unique_id
    tasks << task
    #puts tasks
    redirect '/'
end
 
post '/toggle_task' do
    task_id = params[:task_id]
    task_object = nil
    tasks.each do |task|
        if task.id == task_id.to_i
            task_object = task
            break
        end
    end
    if task_object
            task_object.toggle_task
    end
    redirect '/'
end
