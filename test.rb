require 'sqlite3'
DB = SQLite3::Database.new('tasks.db')
DB.results_as_hash = true
require_relative 'task'

# Implement the READ logic to find a given task (by its id)
# id = 1
# task = Task.find(id)
# puts "#{task.id}. #{task.title} - #{task.description} #{ task.done? ? "✅" : "⬜️" }"

# Implement the CREATE logic in a save instance method
# task = Task.new(title: "Clean the dishes", description: "My favorite task")
# task.save
# puts "#{task.id}. #{task.title} - #{task.description} #{ task.done? ? "✅" : "⬜️" }"

# Implement the UPDATE logic in the same method
# id = 1
# task = Task.find(id)
# task.done!
# task.save
# puts "#{task.id}. #{task.title} - #{task.description} #{ task.done? ? "✅" : "⬜️" }"

# Implement the READ logic to retrieve all tasks (what type of method is it?)
# tasks = Task.all # array of instances of Task
# tasks.each do |task|
#   puts "#{task.id}. #{task.title} - #{task.description} #{ task.done? ? "✅" : "⬜️" }"
# end

# Implement the DESTROY logic on a task
task = Task.find(2)
task.destroy
tasks = Task.all # array of instances of Task
tasks.each do |task|
  puts "#{task.id}. #{task.title} - #{task.description} #{ task.done? ? "✅" : "⬜️" }"
end