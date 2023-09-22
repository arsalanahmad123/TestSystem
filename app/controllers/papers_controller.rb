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
            redirect_to papers_path, notice: "Paper was successfully created."
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
        @paper = Paper.friendly.includes(:questions).find(params[:id])
        @questions = @paper.questions 
    end

    def submitPaper
        @paper = Paper.find(params[:paper_id])
        @questions = @paper.questions
        @user = current_user
        @score = 0

        question_ids = @questions.map(&:id)

        # Fetch all responses for the current user and the questions in one query
        responses = Response.where(user_id: current_user.id, question_id: question_ids).index_by(&:question_id)

        @questions.each do |question|
            selected_answer = params["choice-#{question.id}"].to_i
            response = responses[question.id] || Response.new(user_id: current_user.id, question_id: question.id)

            response.update(choice: selected_answer)
            @score += 1 if selected_answer == question.correct_option
        end

        score = Score.find_or_initialize_by(paper_id: @paper.id, user_id: current_user.id)
        score.update(score: @score, total_question_count: @questions.count)
        redirect_to resultpage_path(@paper)
    end



    def resultpage
        @questions = @paper.questions
        @score = Score.find_by(paper_id: @paper.id,user_id: current_user.id)
        @responses = Response.where(user_id: current_user.id, question_id: @questions.map(&:id))
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

