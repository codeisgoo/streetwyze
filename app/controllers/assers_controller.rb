class AssersController < ApplicationController
  before_action :authenticate_user!
  def index
    @assers = Asser.order(created_at: :desc)
    @assers = @assers.by_category(params[:category]) if params[:category].present?
    @assers = @assers.by_type(params[:type]) if params[:type].present?
    @assers = @assers.with_media if params[:media] == "With Media"
    @assers = @assers.without_media if params[:media] == "Without Media"
    @assers = @assers.by_author(current_user.id) if params[:author] == "Only Me"
    @assers = @assers.created_today if params[:date] == "Today"
    @assers = @assers.created_yesterday if params[:date] == "Yesterday"
    @assers = @assers.created_last_7_days if params[:date] == "Last 7 days"
    @assers = @assers.created_last_30_days if params[:date] == "Last 30 days"
    @assers = @assers.created_this_month if params[:date] == "This Month"
    @assers = @assers.created_last_month if params[:date] == "Last Month"
    @assers = @assers.created_within_range(params[:start_date], params[:end_date]) if params[:date] == "Custom Range" && params[:start_date].present? && params[:end_date].present?
  end

  def new
    @asser = Asser.new
  end

  def edit
    @asser = Asser.find(params[:id])
  end

  def update
    @asser = Asser.find(params[:id])
    
    if @asser.update(asser_params)
      redirect_to assers_path, notice: "Asset updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @asser = Asser.find(params[:id])
    @asser.destroy
    redirect_to assers_path, notice: 'Asset deleted successfully.'
  end


  def show
    @asser = Asser.find(params[:id])
  end

  def create
    @asser = Asser.new(asser_params)
    # asser.media = params[:media]
    if @asser.save
      redirect_to assers_path, notice: 'Asset was successfully created.'
    else
      render :new
    end
  end

  private

  def asser_params
    params.require(:asser).permit(:place_name, :address, :type_of_stuff, :category, :rating, :story_description, :media)
  end
end
