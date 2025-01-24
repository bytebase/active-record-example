class CreateSalary < ActiveRecord::Migration[6.1]
    def change
      create_table :salary do |t|
        t.string :name
        t.integer :amount
        # Add other columns as needed

        t.timestamps
      end
    end
  end 