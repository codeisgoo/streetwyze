require 'csv'
class StoriesController < ApplicationController
  before_action :set_asser


  def index
    # byebug
    @stories = Story.all.order(created_at: :desc)
    @stories = @stories.by_category(params[:category]) if params[:category].present?
    @stories = @stories.by_type_of_stuff(params[:type_of_stuff]) if params[:type_of_stuff].present? && params[:type_of_stuff] != 'All'
    @stories = @stories.with_media if params[:media] == "With Media"
    @stories = @stories.created_today if params[:date] == "Today"
    @stories = @stories.created_yesterday if params[:date] == "Yesterday"
    @stories = @stories.created_last_7_days if params[:date] == "Last 7 days"
    @stories = @stories.created_last_30_days if params[:date] == "Last 30 days"
    @stories = @stories.created_this_month if params[:date] == "This Month"
    @stories = @stories.created_last_month if params[:date] == "Last Month"
    @stories = @stories.created_within_range(params[:start_date], params[:end_date]) if params[:date] == "Custom Range" && params[:start_date].present? && params[:end_date].present?
    if params[:author].present? && params[:author] == 'Only Me'
      @stories = @stories.where(user_id: current_user.id)
    end

    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@stories), filename: "stories_#{Time.now.strftime('%Y%m%d%H%M%S')}.csv" }
    end

  end


  def new
    @story = @asser.stories.build
  end
  
  def create
    @story = @asser.stories.build(story_params)

    if @story.save
      redirect_to asser_stories_path(@asser), notice: 'Story shared successfully.'
    else
      render :new
    end
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  def edit
    @story = current_user.stories.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to asser_stories_path(@asser), notice: "Story not found."
  end

  
  def update
    @story = current_user.stories.find(params[:id])
    if @story.update(story_params)
      redirect_to asser_stories_path(@asser), notice: 'Story updated successfully.'
    else
      render :edit
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to asser_stories_path(@asser), notice: "Story not found."
  end


  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to asser_stories_path(@asser), notice: "Story deleted successfully."
  end
  
  private
  
  def set_asser
    @asser = Asser.find(params[:asser_id])
  end
  
  def story_params
    params.require(:story).permit(:address,:place_name,:type_of_stuff, :category, :rating, :story_description, :media,:asser_id)
  end

  def generate_csv(stories)
    CSV.generate(headers: true) do |csv|
      csv << ['Place Name', 'Type of Stuff', 'Category', 'Rating', 'Story Description']

      stories.each do |story|
        csv << [
          story.asser.place_name,
          story.type_of_stuff,
          story.category,
          story.rating,
          story.story_description
        ]
      end
    end
  end
end
