class EventsController < ApplicationController

  def new
    @event = Event.new
  end
  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "作成完了"
      redirect_to @event
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @circle = Circle.find(@event.circle_id)

    @be_member = @circle.members.include?(current_user)
  end

  def edit
    @event = Event.find(params[:id])
  end
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "編集完了"
      redirect_to @event
    else
      render 'edit'
    end
  end

  private
    def event_params
      params.require(:event).permit(
          :title, :content, :circle_id
        )
    end
end
