class AssersController < ApplicationController
  before_action :authenticate_user!
  def index
    @assers = Asser.all
  end
  
  def new
    @asser = Asser.new
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
