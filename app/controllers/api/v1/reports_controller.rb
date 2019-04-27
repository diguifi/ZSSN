module Api
    module V1
        class ReportsController < ApplicationController
            def infecteds
                render json: {status: 'SUCCESS', data: "#{infecteds_percentage}% of all survivors have been infected (so far...)" }, status: :ok
            end

            def non_infecteds
                render json: {status: 'SUCCESS', data: "#{non_infecteds_percentage}% of all survivors are not infected" }, status: :ok
            end

            def average_items
                render json: {status: 'SUCCESS', data: get_average_items }, status: :ok
            end

            def points_lost
                render json: {status: 'SUCCESS', data: get_points_lost }, status: :ok
            end

            private

            def infecteds_percentage
                return ((infected_survivors_count / all_survivors_count) * 100).round(2)
            end

            def non_infecteds_percentage
                return 100 - infecteds_percentage
            end

            def all_survivors_count
                return Survivor.count.to_f
            end

            def infected_survivors_count
                return Survivor.where(infected: true).count.to_f
            end

            def get_average_items
                water = (Inventory.sum(:water) / all_survivors_count).round(2)
                food = (Inventory.sum(:food) / all_survivors_count).round(2)
                med = (Inventory.sum(:medication) / all_survivors_count).round(2)
                ammo = (Inventory.sum(:ammo) / all_survivors_count).round(2)
            
                return { water_per_survivor: water, food_per_survivor: food,
                  medication_per_survivor: med, ammo_per_survivor: ammo }
            end

            def get_points_lost
                @survivors = Survivor.includes(:inventory).where(infected: true)
                @inventories = @survivors.collect{ |survivors| survivors.inventory }

                total = 0
                @inventories.each do |inventory|
                    total += inventory.water * 4 + inventory.food * 3 + inventory.medication * 2 + inventory.ammo
                end

                return { total_points_lost: total }
            end
        end
    end
end