class CreateSurvivors < ActiveRecord::Migration[5.2]
  def change
    create_table :survivors do |t|
      t.string :name
      t.integer :age
      t.integer :gender
      t.string :latitude
      t.string :longitude
      t.boolean :infected, :default => false

      t.timestamps
    end
  end
end
