
class PhotosController < ApplicationController


  def index
   @photos =Photo.all
  end

  def show
    @tripdetail = Photo.find(params[:id])
    #@photo = @tripdetail.trip
  end


  def new
    @photo = Photo.new
     @tripdetail = Tripdetail.find(params[:tripdetail_id])

  end

  def create
    @tripdetail = Tripdetail.find(params[:tripdetail_id])
    @photo = @tripdetail.photos.build(photo_params)
    binding.pry
    if @photo.save
      redirect_to new_tripdetail_photo_path(@tripdetail), notice: 'Photo was successfully created.'
    else

      redirect_to new_tripdetail_photo_path(@tripdetail), notice: 'Photo was not created.'
    end
  end


  def destroy
   @tripdetail= Photo.find(params[:id])
    @photo = @tripdetail.photo

    if @tripdetail.destroy
      redirect_to trip_path(@photo), notice: "Photo successfully deleted"
    else
      flash[:notice] = "Photo was not deleted"
      render 'show'
    end

  end


  def edit
     @tripdetail = Photo.find(params[:id])
     @photo = @tripdetail.photo
  end

  def update

    @tripdetail = Photo.find(params[:id])
    @photo = @tripdetail.photo
    @tripdetail.update(tripdetail_params)

    if @tripdetail.save
      redirect_to trip_tripdetail_path(@photo, @tripdetail), notice: 'Photo was successfully updated.'
    else
      flash[:notice] = 'Photo was not updated.'
      render action: 'edit'
    end
  end


  private

  def photo_params
    params.require(:photo).permit(:photo_name, :description, :tripdetail_id)
  end


end
