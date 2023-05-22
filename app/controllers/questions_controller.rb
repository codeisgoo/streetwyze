# app/controllers/questions_controller.rb

class QuestionsController < ApplicationController
    # ...
  
    def new
      @question = Question.new
      @survey = Survey.find(params[:survey_id])
    end

    def create
      @question = Question.new(question_params)
      if @question.save
        redirect_to new_question_path(survey_id: @question.survey_id), notice: 'Question added successfully.'
      else
        render :new
      end
    end
  
    private

  def question_params
    params.require(:question).permit(:content, :question_type, options_attributes: [:content, :_destroy, :id])
  end
  
  
    # ...
  end
  