class QuestionsController < ApplicationController
    before_action :set_paper, only: [:new, :create,:destroy]
    before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
    def new 
        @question = @paper.questions.build 
    end

    def create 
        @question = @paper.questions.build(question_params)
        if @question.save
            respond_to do |format|
                format.turbo_stream{
                    render turbo_stream: (
                        [
                        turbo_stream.append("questions", 
                            partial: "questions/question",
                            locals: {question: @question,index: @paper.questions.count}
                            
                        ),
                        turbo_stream.replace("new-question",
                            partial: "questions/form",
                            locals: {question: Question.new,paper: @paper}
                        )
                        ]
                    )
                }
            end
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def destroy 
        @question = @paper.questions.find(params[:id])
        @question.destroy
        respond_to do |format|
            format.turbo_stream{
                render turbo_stream: 
                [turbo_stream.remove(@question),
                    turbo_stream.replace("questions",partial: "questions/questions",locals: {questions: @paper.questions})
                ]
            }
        end
    end

    def edit 
        @paper = Paper.friendly.find(params[:paper_id])
        @question = @paper.questions.find(params[:id])
    end

    def update 
        @paper = Paper.friendly.find(params[:paper_id])
        @question = @paper.questions.find(params[:id])
        @question.update(question_params)
        redirect_to paper_path(@paper), notice: "Question was successfully updated."
    end


    private 

        def set_paper 
            @paper = Paper.friendly.find(params[:paper_id])
        end

        def question_params
            params.require(:question).permit(:content, :correct_option,:paper_id,:choice1,:choice2,:choice3,:choice4)
        end
end
