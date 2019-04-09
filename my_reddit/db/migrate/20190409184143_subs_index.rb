class SubsIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :subs, :title, unique: true
    add_index :subs, :moderator_id
  end
end
