class Task < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    description :string
    timestamps
  end
   attr_accessible :description, :story, :story_id, :task_assignments, :users

  belongs_to :story, :inverse_of => :tasks, :counter_cache => true

  has_many :task_assignments, :dependent => :destroy, :inverse_of => :task
  has_many :users, :through => :task_assignments

  # --- Permissions --- #

  def create_permitted?
     acting_user.signed_up?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
