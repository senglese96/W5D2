class FixSubs < ActiveRecord::Migration[5.2]
  def change
    remove_column :subs, :title
    add_column :subs, :title, :string, null: false
    remove_column :subs, :description
    add_column :subs, :description, :string, null: false
    remove_column :subs, :moderator_id
    add_column :subs, :moderator_id, :integer, null: false
  end
end
