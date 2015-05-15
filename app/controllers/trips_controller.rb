class TripsController < ApplicationController

  #before_action :authenticate_user!, :only => [:edit, :update, :destroy]

  def index

    @trips = Trip.all.page(params[:page]).per(8)
    @location_array = []
    @content_array = []

    @trips.each do|loc|
       @location_array << [loc.latitude, loc.longitude]
    end
    @trips.each do|loc|
      @content_array << "<a style=\"font-style:italic\"href=\"trips/#{loc.id}\">#{loc.address.split(',').first}</a>"
    end
  end

  def show
    @playflag = false
    @trip = Trip.find(params[:id])
    #@hunts = @trip.hunts.page(params[:page]).per(3)
  end

  def new
    @trip = Trip.new
    @trips = Trip.all
  end



  def create

      @trip= Trip.create(trip_params)

      if @trip.save
        redirect_to new_trip_path, notice: 'Trip was successfully created.'
      else
        render action: 'new'
      end

  end


  def destroy
    @trip = Trip.find(params[:id]).destroy
    redirect_to @trip, notice: 'Trip was successfully deleted'
  end


  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    if @trip.save
      redirect_to @trip, notice: 'Trip was successfully edited.'
    else
      render action: 'edit'
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:name,:latitude, :longitude, :address, :trip_date, :description)
  end


end
