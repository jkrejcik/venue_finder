class ReviewsController < ApplicationController
  before_action :set_venue, only: %i[index new create]
  before_action :set_booking, only: %i[new create]

  def index
    @reviews = Review.all.select { |review| review.venue == @venue }
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.venue = @venue
    @review.booking = @booking
    if @review.save
      flash[:notice] = "Thanks for your review!"
      redirect_to venue_reviews_path(@venue)
    else
      render 'new'
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def set_booking
    @booking = current_user.bookings.find { |booking| booking.venue == @venue }
  end

  def review_params
    params.require(:review).permit(:title, :comment, :rating)
  end
end
