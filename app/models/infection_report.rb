class InfectionReport < ApplicationRecord
  belongs_to :survivor_reported, class_name: 'Survivor'
  belongs_to :survivor_reporter, class_name: 'Survivor'
end
