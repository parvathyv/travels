class QuestionsetsController < ApplicationController
  before_action :authenticate_user!, :only => [:show, :edit, :update, :destroy]

  def index

  end

  def show

    @hunt = Hunt.find(params[:hunt_id])
    @itinerary_array = []
    @content_array = ["1","2","3","4","5"]

    @questionset = Questionset.find(params[:id])
   # @itinerary =['You have to play']
    @itinerary_array = [@hunt.location.latitude, @hunt.location.longitude]
    @huntsplayed = Huntsplayeduser.if_exists?(params[:hunt_id], session.id, current_user.id)

    if @huntsplayed.empty? == false && @huntsplayed.count < 5
      maxquestion_no = Huntsplayeduser.hunt_check(@huntsplayed.last.question_no, params[:hunt_id], session.id)
      @itinerary_array = @questionset.uptoquestion(maxquestion_no.question_no)

      if maxquestion_no.question_no < 5
        if @questionset.question_no == maxquestion_no.question_no
          @questionset = @questionset.next
          @huntsplayed = Huntsplayeduser.new
        else
          if @questionset.question_no - maxquestion_no.question_no > 1 || maxquestion_no.question_no > @questionset.question_no
            @questionset = Questionset.where("question_no=? and hunt_id=?", maxquestion_no.question_no + 1, params[:hunt_id]).first
            @huntsplayed = Huntsplayeduser.new

            if @questionset.question_no - maxquestion_no.question_no > 1
              @msg = "Wrong Order"
            else
              @msg = "Try again"
            end
          else
            if @questionset.question_no - maxquestion_no.question_no == 1
              @huntsplayed = Huntsplayeduser.new
            end
          end
        end
      end

    else

      if @huntsplayed.count == 5
          @content_array = @hunt.questionsets.map{|question| question.description}
          redirect_to tree_path(@questionset.hunt.id), notice: 'You are done with this hunt! If you want to play again, sign in or Sign up'
      else
        @huntsplayed = Huntsplayeduser.new
        @msg = "Let's go..."
      end
    end

  end


  def new
    @questionset = Questionset.new
    @hunt = Hunt.find(params[:hunt_id])
  end


  def create
    @hunt = Hunt.find(params[:hunt_id])
    @questionset = @hunt.questionsets.build(questionset_params)
    @last_quiz = Questionset.where("hunt_id=?", @hunt.id)

    if @last_quiz == nil || @last_quiz.empty?
      @questionset.question_no = 1
    else
      @questionset.question_no = @last_quiz.last.question_no + 1
    end

    if current_user.id == @hunt.user_id

      if @questionset.save
       if @questionset.question_no < 6
          redirect_to new_hunt_questionset_path(@hunt), notice: 'Question was successfully created.'
        else
          redirect_to hunt_path(@hunt), notice: 'Question was successfully created.'
        end
      else
        flash[:notice] = 'Question was not created.'
        render :'new'
        #redirect_to new_hunt_questionset_path(@hunt, Questionset.new), notice: 'Question was not created.'
      end
    else
      redirect_to hunt_path(@hunt), notice: 'Only the hunt owner can add questions'
    end
  end


  def edit
    @questionset = Questionset.find(params[:id])
  end

  def update

    @hunt = Hunt.find(params[:hunt_id])
    @questionset = Questionset.find(params[:id])
    @questionset.update(questionset_params)

    if @questionset.save
      redirect_to @hunt, notice: 'Questionset was successfully updated'
    else
      @questionset = Questionset.find(params[:id])
      @huntsplayed = Huntsplayeduser.new
      flash[:notice] = 'Questionset not updated'
      render 'show'
    end

  end

  private

  def questionset_params
    params.require(:questionset).permit(:hunt_id, :hunt_photo, :description, :question, :question_no, :address, :latitude, :longitude)
  end


end
