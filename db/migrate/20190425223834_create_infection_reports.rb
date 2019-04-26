class CreateInfectionReports < ActiveRecord::Migration[5.2]
  def change
    create_table :infection_reports do |t|
      t.references :survivor_reported
      t.references :survivor_reporter

      t.timestamps
    end
  end
end
