# app/controllers/surveys_controller.rb
class SurveysController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    def new
      @survey = Survey.new
    end
  
    def create
      @survey = current_user.surveys.build(survey_params)
      if @survey.save
        redirect_to surveys_path, notice: "Survey created successfully."
      else
        render :new
      end
    end
  
    def index
      @surveys = Survey.all
    end
  
    def show
      @survey = Survey.find(params[:id])
    end
  
    private
  
    def survey_params
        params.require(:survey).permit(:title, :survey_script, questions_attributes: [:id, :content, :question_type, :_destroy])
    end
  end
  