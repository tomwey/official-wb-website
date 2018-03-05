class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.string :code, null: false

      t.timestamps null: false
    end
    add_index :tags, :name, unique: true
    add_index :tags, :code, unique: true
  end
end
