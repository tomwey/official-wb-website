class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :uniq_id
      t.string :name, null: false
      t.string :cover, null: false
      t.text :body, null: false
      t.string :tags, array: true, default: []
      t.integer :visit, default: 0
      t.integer :sort, default: 0
      t.boolean :opened, default: false

      t.timestamps null: false
    end
    add_index :projects, :uniq_id, unique: true
    add_index :projects, :sort
  end
end
