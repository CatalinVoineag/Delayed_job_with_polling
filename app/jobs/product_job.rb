class ProductJob < Struct.new(:depot_id, :queue, :priority)
  class JobErrorException < StandardError; end

  def enqueue(job)
    job.status = 'processing'
    job.delayed_reference_id   = depot_id
    job.delayed_reference_type = 'Product:Export'
    job.queue = queue
    job.priority = priority
    job.save!
  end

  def before(job)
    @job = job
  end

  def success(job)
    job.update_attribute(:status, 'success') 
  end

  def error(job, exception)
    job.update_attribute(:status, 'error')
  end

  def failure(job)
    job.update_attribute(:status, 'failure')
  end

  def perform
    require 'csv'
    products = Product.all
    step = 1
    @job.progress_max = products.count
    csv_string = CSV.generate do |csv|
      products.each do |product|
        csv << [product.product_code, product.cost]
        @job.update_attribute(:progress_current, @job.progress_current + 1)
      end
    end
    File.open('public/export.csv', 'w') { |f| f.write(csv_string) }
  end
end