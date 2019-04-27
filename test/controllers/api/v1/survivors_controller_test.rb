require 'test_helper'

module Api
    module V1
        class SurvivorsControllerTest < ActionDispatch::IntegrationTest
            setup do
                survivor = survivors(:one)
            end

            test "creates_survivor" do
                survivor_params = {
                    name: "string",
                    age: 1,
                    gender: 0,
                    latitude: "0.000",
                    longitude: "0.000",
                    inventory_attributes:
                    {
                        water: 0,
                        food: 0,
                        medication: 0,
                        ammo: 0
                    }
                }

                post api_v1_survivors_path, params: survivor_params
                assert_response :ok
            end
        end
    end
end