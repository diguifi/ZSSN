class CreateInfectionReports < ActiveRecord::Migration[5.2]
  def change
    create_table :infection_reports do |t|
      t.references :survivor_reported, foreign_key: true
      t.references :survivor_reporter, foreign_key: true

      t.timestamps
    end
  end
end
