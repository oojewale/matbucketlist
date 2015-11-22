class Api::V1::BucketlistsController < ApplicationController
  def initialize
    @bucket_poro = BucketPoro.new
  end

  def index
    if params.count == 2
      to_do = []
      bucket_data = Bucketlist.all
      bucket_data.each { | data | to_do << @bucket_poro.data_formatter(data) }
    elsif params[:q]
      bucket_data = Bucketlist.find_by(name: params[:q])
    elsif params[:page] # Refactor this branch into one with the above
      bucket_data = Bucketlist.get_bucketlist("name", params[:q])
    end
    to_do = @bucket_poro.data_formatter(bucket_data) unless to_do
    render json: to_do
  end

  def new
  end

  def create
  end

  def show
    bucket_data = Bucketlist.find(params[:id])
    to_do = @bucket_poro.data_formatter(bucket_data)
    render json: to_do
  end

  def edit
  end

  def update
  end

  def destroy
  end

end