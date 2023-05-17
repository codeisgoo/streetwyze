class StoriesController < ApplicationController
  before_action :set_asset

  def new
    # byebug
    @story = @asser.stories.build
  end

  def create
    # byebug
    @story = @asser.stories.build(story_params)

    if @story.save
      redirect_to @asser, notice: 'Story shared successfully.'
    else
      render :new
    end
  end

  private

  def set_asset
    @asser = Asser.find(params[:asser_id])
  end

  def story_params
    params.require(:story).permit(:type_of_stuff, :category, :rating, :story_description, :media, :asser_id)
  end
end
