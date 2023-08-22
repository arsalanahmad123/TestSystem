class PapersController < ApplicationController
    before_action :require_user, only: [:index]
    before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_paper, only: [:show, :edit, :update, :destroy]
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

    end

    private 

        def paper_params
            params.require(:paper).permit(:title, :description, :minutes)
        end

        def set_paper 
            @paper = Paper.friendly.find(params[:id])
        end

end

