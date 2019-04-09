class CreateSubtags < ActiveRecord::Migration[5.2]
  def change
    create_table :subtags do |t|
      t.integer :sub_id, null: false
      t.integer :post_id, null: false
      t.timestamps
    end
    add_index :subtags, :sub_id
    add_index :subtags, :post_id
  end
end
