class ReviewsController < ApplicationController
  before_action :set_venue, only: %i[index new]
  def index
    @reviews = Review.all

  end

# def show
#   @review = Revie
# end

  def new
    @review = Review.new
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end
end
