class VenuesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]
  before_action :set_venue, only: %i[show edit update destroy]

  def index
    if params[:query].present?
      @venues = Venue.search_by_name_address_description(params[:query])
    else
      @venues = Venue.all
    end
  end

  def show
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    @venue.user = current_user
    if @venue.save
      flash[:notice] = "Your venue was created!"
      redirect_to venue_path(@venue)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @venue.update(venue_params)
    redirect_to venue_path(@venue)
  end

  def destroy
    @venue.destroy
    redirect_to venues_path, status: :see_other
  end

  def my_venues
    @venues = Venue.where(user: current_user)
    render :index
  end

  private

  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
    params.require(:venue).permit(:name, :address, :capacity, :price, :description, :available_start_date, :available_end_date, :city, :country, :building, photos: [])
  end
end
