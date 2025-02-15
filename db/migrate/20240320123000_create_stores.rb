class CreateStores < ActiveRecord::Migration[6.1]
    def change
      create_table :stores do |t|
        t.string :name, null: false
        t.timestamps
      end

      add_index :stores, :name, unique: true
    end
  end 