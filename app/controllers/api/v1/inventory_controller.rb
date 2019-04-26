module Api
    module V1
        class InventoryController < ApplicationController

            def index
                inventory = Inventory.where(survivor_id: params[:survivor_id])

                render json: {status: 'SUCCESS', data: inventory},status: :ok
            end

            def trade
                @survivor_one = Survivor.find(params[:survivor_one_items][:survivor_id])
                @survivor_two = Survivor.find(params[:survivor_two_items][:survivor_id])
                errors = []

                if any_infected_trader
                    errors.push("Infecteds are not allowed to trade")
                end
                if incorrect_amount_offered
                    errors.push("Please check if any ammount offered exceeds the maximum of items on ones inventory")
                end
                if invalid_trade
                    errors.push("The trade must have equivalent points")
                end

                if errors.any?
                    render json: {status: 'ERROR', data: errors},status: :unprocessable_entity
                else
                    if trade_items
                        render json: {status: 'SUCCESS', data: "The trade was successful"},status: :ok
                    else
                        render json: {status: 'ERROR', data: "An error occurred while processing the trade"},status: :unprocessable_entity
                    end
                end
            end

            private

            def trade_params
                params.permit(:survivor_one_items => [:survivor_id, :water, :food, :medication, :ammo],
                            :survivor_two_items => [:survivor_id, :water, :food, :medication, :ammo])
            end

            def any_infected_trader
                return @survivor_two.infected || @survivor_one.infected
            end

            def incorrect_amount_offered
                if ((@survivor_one.inventory.water < params[:survivor_one_items][:water]) ||
                    (@survivor_one.inventory.food < params[:survivor_one_items][:food]) ||
                    (@survivor_one.inventory.medication < params[:survivor_one_items][:medication]) ||
                    (@survivor_one.inventory.ammo < params[:survivor_one_items][:ammo]))
                    return true
                elsif ((@survivor_two.inventory.water < params[:survivor_two_items][:water]) ||
                    (@survivor_two.inventory.food < params[:survivor_two_items][:food]) ||
                    (@survivor_two.inventory.medication < params[:survivor_two_items][:medication]) ||
                    (@survivor_two.inventory.ammo < params[:survivor_two_items][:ammo]))
                    return true
                else
                    return false
                end
            end

            def invalid_trade
                survivor_one_worth = params[:survivor_one_items][:water] * 4 + params[:survivor_one_items][:food] * 3 + params[:survivor_one_items][:medication] * 2 + params[:survivor_one_items][:ammo]
                survivor_two_worth = params[:survivor_two_items][:water] * 4 + params[:survivor_two_items][:food] * 3 + params[:survivor_two_items][:medication] * 2 + params[:survivor_two_items][:ammo]
                return survivor_one_worth != survivor_two_worth
            end

            def trade_items
                survivor_one_water = @survivor_one.inventory.water + params[:survivor_two_items][:water] - params[:survivor_one_items][:water]
                survivor_one_food = @survivor_one.inventory.food + params[:survivor_two_items][:food] - params[:survivor_one_items][:food]
                survivor_one_med = @survivor_one.inventory.medication + params[:survivor_two_items][:medication] - params[:survivor_one_items][:medication]
                survivor_one_ammo = @survivor_one.inventory.ammo + params[:survivor_two_items][:ammo] - params[:survivor_one_items][:ammo]
                @survivor_one.inventory.update_attribute(:water,survivor_one_water)
                @survivor_one.inventory.update_attribute(:food,survivor_one_food)
                @survivor_one.inventory.update_attribute(:medication,survivor_one_med)
                @survivor_one.inventory.update_attribute(:ammo,survivor_one_ammo)

                survivor_two_water = @survivor_two.inventory.water + params[:survivor_one_items][:water] - params[:survivor_two_items][:water]
                survivor_two_food = @survivor_two.inventory.food + params[:survivor_one_items][:food] - params[:survivor_two_items][:food]
                survivor_two_med = @survivor_two.inventory.medication + params[:survivor_one_items][:medication] - params[:survivor_two_items][:medication]
                survivor_two_ammo = @survivor_two.inventory.ammo + params[:survivor_one_items][:ammo] - params[:survivor_two_items][:ammo]
                @survivor_two.inventory.update_attribute(:water,survivor_two_water)
                @survivor_two.inventory.update_attribute(:food,survivor_two_food)
                @survivor_two.inventory.update_attribute(:medication,survivor_two_med)
                @survivor_two.inventory.update_attribute(:ammo,survivor_two_ammo)

                return true
            end

        end
    end
end