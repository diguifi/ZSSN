class Survivor < ApplicationRecord
    has_one :inventory, dependent: :destroy
    has_many :infection_reported, class_name: 'InfectionReport', foreign_key: 'survivor_reporter_id'
    has_many :infection_received, class_name: 'InfectionReport', foreign_key: 'survivor_reported_id'
	accepts_nested_attributes_for :inventory
end
