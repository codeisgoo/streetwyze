class StoriesController < ApplicationController
  before_action :set_asser

  def index
    # byebug
    @stories = Story.all.order(created_at: :desc)
  end

  def new
    @story = @asser.stories.build
  end

  def create
    # byebug
    @story = @asser.stories.build(story_params)

    if @story.save
      redirect_to asser_stories_path, notice: 'Story shared successfully.'
    else
      render :new
    end
  end

  def show
    @story = Story.find(params[:id])
  end


  def edit
    @story = Story.find(params[:id])
    redirect_to root_path, notice: "You can only edit your own stories." unless @story.user_id == current_user.id
  end

  def update
    @story = Story.find(params[:id])
    # Add logic to restrict updating to the current user's story
    redirect_to root_path, notice: "You can only update your own stories." unless @story.user_id == current_user.id

    if @story.update(story_params)
      redirect_to @story, notice: "Story updated successfully."
    else
      render :edit
    end
  end


  def destroy
    @story = Story.find(params[:id])

    redirect_to root_path, notice: "You can only delete your own stories." unless @story.user_id == current_user.id

    @story.destroy
    redirect_to stories_path, notice: "Story deleted successfully."
  end


  private

  def set_asser
    @asser = Asser.find(params[:asser_id])
  end

  def story_params
    params.require(:story).permit(:address,:place_name,:type_of_stuff, :category, :rating, :story_description, :media, :asser_id)
  end
end
