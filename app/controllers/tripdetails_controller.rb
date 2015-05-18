
class TripdetailsController < ApplicationController
  before_action :authenticate_user!, :only => [:edit, :update, :destroy]

  def index
   @tripdetails = Tripdetail.all
  end

  def show
    @tripdetail = Tripdetail.find(params[:id])
    @trip = @tripdetail.trip

  end


  def new
    @tripdetail = Tripdetail.new
    @trip = Trip.find(params[:trip_id])
  end

  def create
    @trip = Trip.find(params[:trip_id])
    @tripdetail = @trip.tripdetails.build(tripdetail_params)

    if @tripdetail.save
      redirect_to trip_tripdetail_path(@trip, @tripdetail), notice: 'Tripdetail was successfully created.'
    else
      binding.pry
      redirect_to new_trip_tripdetail_path(@trip), notice: 'Tripdetail was not created.'
    end
  end


  def destroy
   @tripdetail= Tripdetail.find(params[:id])
    @trip = @tripdetail.trip

    if @tripdetail.destroy
      redirect_to trip_path(@trip), notice: "Tripdetail successfully deleted"
    else
      flash[:notice] = "Tripdetail was not deleted"
      render 'show'
    end

  end


  def edit
     @tripdetail = Tripdetail.find(params[:id])
     @trip = @tripdetail.trip
  end

  def update

    @tripdetail = Tripdetail.find(params[:id])
    @trip = @tripdetail.trip
    @tripdetail.update(tripdetail_params)

    if @tripdetail.save
      redirect_to trip_tripdetail_path(@trip, @tripdetail), notice: 'Tripdetail was successfully updated.'
    else
      flash[:notice] = 'Tripdetail was not updated.'
      render action: 'edit'
    end
  end


  private

  def tripdetail_params
    params.require(:tripdetail).permit(:name, :address, :description,:latitude, :longitude, :trip_id)
  end


end
