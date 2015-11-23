class Api::V1::BucketlistsController < ApplicationController

  def index
    begin
      bucket_data = params_processor(params)
      render json: bucket_data, root: false
    rescue
      render json: [], root: false
    end
  end

  def new
  end

  def create
  end

  def show
    begin
      bucket_data = Bucketlist.find(params[:id])
      render json: bucket_data, root: false
    rescue
      render json: [], root: false
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def numeric?(item)
    /\d+/.match("#{item}")
  end

  def params_processor(params)
    if params.count == 2
      Bucketlist.all
    elsif params[:q]
      Bucketlist.find_by(name: params[:q])
    elsif numeric?(params[:page]) && numeric?(params[:limit])
      Bucketlist.get_by_page(params[:page], params[:limit])
    end
  end

end