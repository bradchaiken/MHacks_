class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string   :title
      t.text     :body
      t.string   :status
      t.integer  :tasks_count, :default => 0, :null => false
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :hack_id
    end
    add_index :stories, [:hack_id]

    create_table :hacks do |t|
      t.string   :name
      t.integer  :stories_count, :default => 0, :null => false
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :tasks do |t|
      t.string   :description
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :story_id
    end
    add_index :tasks, [:story_id]

    create_table :task_assignments do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id
      t.integer  :task_id
    end
    add_index :task_assignments, [:user_id]
    add_index :task_assignments, [:task_id]
  end

  def self.down
    drop_table :stories
    drop_table :hacks
    drop_table :tasks
    drop_table :task_assignments
  end
end
