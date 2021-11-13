class Task
  attr_reader :id
  attr_accessor :title, :description

  def initialize(attributes = {})
    # when querying the DB, we get a hash with String keys!
    # so let's make the initialize understand them as well.
    @id = attributes[:id] || attributes['id']
    @title = attributes[:title] || attributes['title']
    @description = attributes[:description] || attributes['description']
    @done = attributes[:done] || attributes['done'] || false
  end

  def self.find(id)
    DB.results_as_hash = true
    task = DB.execute('SELECT * FROM tasks WHERE id = ?', id).first
    task['done'] = task['done'] == 1 # what is equal to 1 or 0? and should be true or false
    Task.new(task)
  end

  def save
    if @id.nil?
      query = 'INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)'
      DB.execute(query, @title, @description, done? ? 1 : 0)
      @id = DB.last_insert_row_id
    else
      query = 'UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?'
      DB.execute(query, @title, @description, done? ? 1 : 0, @id)
    end
  end

  def self.all
    DB.results_as_hash = true
    query = 'SELECT * FROM tasks'
    tasks = DB.execute(query)
    tasks.map do |task| 
      task['done'] = task['done'] == 1
      Task.new(task)
    end
  end

  def destroy
    query = 'DELETE FROM tasks WHERE id = ?'
    DB.execute(query, @id)
  end

  def done!
    @done = true
  end

  def done?
    @done
  end
end