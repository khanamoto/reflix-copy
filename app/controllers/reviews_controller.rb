class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to work_url(id: @review.work_id)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:work_id, :user_id, :title, :body)
  end
end
