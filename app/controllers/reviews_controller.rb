class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]

  respond_to :html

  def edit
    @place = @review.place
  end

  def create
    @review = current_user.reviews.new(review_params)

    respond_to do |format|
			if @review.save
				format.html {redirect_to place_path(@review.place), notice: "Yeah!" }
			else
				format.html {redirect_to place_path(@review.place), notice: ":("}
			end	
    end
    #@review.save
    #respond_with(@review)
  end

  def update
    respond_to do |format|
		if @review.update(review_params)
				format.html {redirect_to place_path(@review.place), notice: "Yeah! modificate" }
			else
				format.html {redirect_to place_path(@review.place), notice: ":("}
			end	
    end
    #@review.update(review_params)
    #respond_with(@review)
  end

  def destroy
    if @review.destroy
			format.html {redirect_to place_path(@review.place), notice: "Yeah! deleted" }
		else
			format.html {redirect_to place_path(@review.place), notice: ":("}
		end	
    #@review.destroy
    #respond_with(@review)
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:place_id, :content, :score)
    end
end