module Api
    module V1
        class InfectionReportsController < ApplicationController

            def index
                infection_reports = InfectionReport.order('created_at DESC');
            
                render json: {status: 'SUCCESS', data: infection_reports},status: :ok
            end
        
            def show
                infection_report = InfectionReport.find(params[:id])
                render json: {status: 'SUCCESS', data: infection_report},status: :ok
            end
        
            def create
                success = false
                issuer = Survivor.find(params[:survivor_reporter_id])
                if issuer.infected
                    returned_data = "Infecteds can't report"
                else
                    infection_report = InfectionReport.new(infection_report_params)

                    if infection_report.save
                        survivor = Survivor.find(params[:survivor_reported_id])
                        is_infected = survivor.infection_received.distinct(&:survivor_reporter_id).size >= 3
                        if is_infected
                            survivor.update_attribute(:infected,true)
                        end

                        success = true
                        returned_data = infection_report
                    else
                        returned_data = infection_report.errors
                    end
                end

                if success
                    render json: {status: 'SUCCESS', data: returned_data},status: :ok
                else
                    render json: {status: 'ERROR', data: returned_data},status: :unprocessable_entity
                end
            end
        
            def destroy
                infection_report = InfectionReport.find(params[:id])
                infection_report.destroy
                render json: {status: 'SUCCESS', data: []},status: :ok
            end
        
            private

            def infection_report_params
                params.permit(:survivor_reported_id, :survivor_reporter_id)
            end
        end
    end
end