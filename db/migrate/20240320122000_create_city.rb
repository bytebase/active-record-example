class CreateCity < ActiveRecord::Migration[6.1]
    def change
      create_table :city do |t|
        t.string :name, null: false
        t.timestamps
      end

      add_index :city, :name, unique: true
    end
  end 