class CreateCity < ActiveRecord::Migration[6.1]
    def change
      create_table :city do |t|
        t.string :name
        t.string :country
        # Add other columns as needed
        
        t.timestamps
      end
    end
  end 
