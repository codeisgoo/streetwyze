require 'csv'
class AssersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_asset, only: [:show, :edit, :update, :destroy]

  def index
    @assers = Asser.order(created_at: :desc)
    @assers = @assers.by_category(params[:category]) if params[:category].present?
    @assers = @assers.by_type_of_stuff(params[:type_of_stuff]) if params[:type_of_stuff].present? && params[:type_of_stuff] != 'All'
    @assers = @assers.with_media if params[:media] == "With Media"
    @assers = @assers.created_today if params[:date] == "Today"
    @assers = @assers.created_yesterday if params[:date] == "Yesterday"
    @assers = @assers.created_last_7_days if params[:date] == "Last 7 days"
    @assers = @assers.created_last_30_days if params[:date] == "Last 30 days"
    @assers = @assers.created_this_month if params[:date] == "This Month"
    @assers = @assers.created_last_month if params[:date] == "Last Month"
    @assers = @assers.created_within_range(params[:start_date], params[:end_date]) if params[:date] == "Custom Range" && params[:start_date].present? && params[:end_date].present?
    if params[:author].present? && params[:author] == 'Only Me'
      @assers = @assers.where(user_id: current_user.id)
    end


    respond_to do |format|
      format.html
      format.csv { send_data generate_csv(@assers), filename: "assers_#{Time.now.strftime('%Y%m%d%H%M%S')}.csv" }
    end
  end

  def new
    @asser = Asser.new
  end

  def edit
    @asser = Asser.find(params[:id])
    authorize_user(@asser)
  end

  def update
    @asser = Asser.find(params[:id])
    authorize_user(@asser)

    if @asser.update(asser_params)
      redirect_to assers_path, notice: "Asset updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @asser = Asser.find(params[:id])
    authorize_user(@asser)
    @asser.destroy
    redirect_to assers_path, notice: 'Asset deleted successfully.'
  end

  def show
    @asser = Asser.find(params[:id])
  end

  def create
    @asser = Asser.new(asser_params)
    @asser.user_id = current_user.id
    if @asser.save
      redirect_to assers_path, notice: 'Asset was successfully created.'
    else
      render :new
    end
  end

  private

  def authorize_user(asser)
    unless asser.user_id == current_user.id
      redirect_to root_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def set_asset
    @asser = Asser.find(params[:id])
  end

  def asser_params
    params.require(:asser).permit(:place_name, :address, :type_of_stuff, :category, :rating, :story_description, :media => [])
  end

  def generate_csv(assers)
    CSV.generate(headers: true) do |csv|
      csv << ['Place Name', 'Address', 'Type of Stuff', 'Category', 'Rating', 'Story Description','media']

      assers.each do |asser|
        csv << [
          asser.place_name,
          asser.address,
          asser.type_of_stuff,
          asser.category,
          asser.rating,
          asser.story_description,
          asser.media
        ]
      end
    end
  end
end