class ProductsController < ApplicationController

  def index
    @job = Delayed::Job.first
  end

  def download_csv
    @job = Delayed::Job.enqueue ProductJob.new(params[:depot_id], 'export_csv', 0)
  end

  def progress_job
    @job = Delayed::Job.where(id: params[:job_id]).first
    if @job.present?
       percentage = !@job.progress_max.zero? ? @job.progress_current / @job.progress_max.to_f * 100 : 0
       render json: @job.attributes.merge!(percentage: percentage).to_json
   	else
  		render json: ''
    end
  end

end