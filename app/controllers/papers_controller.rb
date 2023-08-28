class PapersController < ApplicationController
    before_action :require_user, only: [:index]
    before_action :require_admin, only: [:new, :create, :edit, :update, :destroy,:allowpaper]
    before_action :set_paper, only: [:show, :edit, :update, :destroy,:resultpage,:allowpaper]
    before_action :require_approved_user,only: [:paperstart,:submitPaper,:resultpage]

    def index 
        @papers = Paper.all
        @paper = Paper.new 
    end 

    def new 
        @paper = Paper.new 
    end

    def show 
    end

    def create 
        @paper = Paper.new(paper_params)
        if @paper.save
            respond_to do |format|
                format.turbo_stream{
                    render turbo_stream: 
                    [turbo_stream.prepend("papers", @paper),
                        turbo_stream.replace("new-paper",partial: "papers/form",locals: {paper: Paper.new})
                    ]
                }
            end
        else
            render 'new', :status => :unprocessable_entity
        end
    end

    def edit

    end

    def update

    end

    def destroy
        @paper.destroy
        respond_to do |format|
            format.turbo_stream{
                render turbo_stream: 
                [
                turbo_stream.remove(@paper),
                turbo_stream.replace("papers",partial: "papers/papers",locals: {papers: Paper.all})
                ]
            }
        end
    end


    def paperstart 
        @paper = Paper.friendly.find(params[:id])
        @questions = @paper.questions 
    end

    def submitPaper 
        @paper = Paper.find(params[:paper_id])
        @questions = @paper.questions
        @user = current_user
        @score = 0
        @questions.each do |question|
            selected_answer = params["choice-#{question.id}"] if params["choice-#{question.id}"]
            selected_answer = selected_answer.to_i
            response = Response.find_or_initialize_by(user_id: @user.id,question_id: question.id)
                response.update(choice: selected_answer.to_i)
                
                if  selected_answer == question.correct_option
                    @score = @score + 1
                end 
        end
        score = Score.find_or_initialize_by(paper_id: @paper.id, user_id: @user.id,total_question_count: @paper.questions.count)
        score.update(score: @score)
        redirect_to resultpage_path(@paper)
    end

    def resultpage
        @questions = @paper.questions
        @score = Score.find_by(paper_id: @paper.id,user_id: current_user.id)
        @responses = []
        @questions.each do |question|
            response = Response.find_by(user_id: current_user.id,question_id: question.id)
            @responses << response 
        end
    end

    def allowpaper 
        if @paper.allowed?
            @paper.update(allowed: false)
        else
            @paper.update(allowed: true)
        end

        respond_to do |format|
            format.turbo_stream do
                render turbo_stream: [
                turbo_stream.replace("access", partial: "papers/access", locals: { paper: @paper })
                ]
            end
        end
    end



    private 

        def paper_params
            params.require(:paper).permit(:title, :description, :minutes)
        end

        def set_paper 
            @paper = Paper.friendly.find(params[:id])
        end

        def check_paper_allowed?
            unless @paper.allowed?
                flash[:error] = "Currently paper is not allowed"
                redirect_to request.referrer || root_path
            end
        end

end

