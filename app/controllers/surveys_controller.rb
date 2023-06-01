class SurveysController < ApplicationController
  def new
    @survey = Survey.new
    @survey.questions.build
  end

  def create
    @survey = current_user.surveys.build(survey_params)
    if @survey.save
      redirect_to @survey, notice: 'Survey published successfully.'
    else
      render :new
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def index
    @surveys = current_user.surveys
  end


  private

  def survey_params
    params.require(:survey).permit(:title, :survey_script, questions_attributes: [:id, :question_body, :question_type, :_destroy])
  end
end
