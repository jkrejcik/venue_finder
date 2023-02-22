class BookingsController < ApplicationController
  before_action :set_venue, only: %i[new create destroy]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.venue = @venue
    @booking.save
    if @booking.save
      redirect_to bookings_path
    else
      render 'new'
    end
  end

  def index
    @bookings = Booking.where(user_id: current_user.id)
  end

  def destroy
    @booking.destroy
    redirect_to venue_path, status: :see_other
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def booking_params
    params.require(:booking).permit(:booking_start_date, :booking_end_date)
  end
end
