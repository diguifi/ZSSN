module Api
    module V1
        class SurvivorsController < ApplicationController
            def index
                survivors = Survivor.order('created_at DESC');
                render json: {status: 'SUCCESS', data: survivors},status: :ok
            end

            def show
                survivor = Survivor.find(params[:id])
                render json: {status: 'SUCCESS', data: survivor},status: :ok
            end

            def create
                survivor = Survivor.new(survivor_params)
                if survivor.save
                    render json: {status: 'SUCCESS', data: survivor},status: :ok
                else
                    render json: {status: 'ERROR', data: survivor.errors},status: :unprocessable_entity
                end
            end

            def update
                survivor = Survivor.find(params[:id])
                if survivor.update_attributes(update_params)
                    render json: {status: 'SUCCESS', data: survivor},status: :ok
                else
                    render json: {status: 'ERROR', data: survivor.errors},status: :unprocessable_entity
                end
            end

            def destroy
                survivor = Survivor.find(params[:id])
                survivor.destroy
                render json: {status: 'SUCCESS', data: survivor},status: :ok
            end

            def survivor_params
                params.permit(:name, :age, :gender, :latitude, :longitude,
                    :inventory_attributes => [:survivor_id, :water, :food, :medication, :ammo])
            end

            def update_params
                params.require(:survivor).permit(:latitude, :longitude)
            end
        end
    end
end