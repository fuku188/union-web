class CirclesController < ApplicationController

  def new
    @circle = Circle.new
  end
  def create
    @circle = Circle.new(circle_params)
    if @circle.save
      flash[:success] = "作成完了"
      @membership = Membership.create(member_id: current_user.id, circle_id: @circle.id)
      redirect_to @circle
    else
      render 'new'
    end
  end

  def show
    @circle = Circle.find(params[:id])

    @members = @circle.members
    @blogs   = @circle.blogs
    @events  = @circle.events

    @be_member = @members.include?(current_user)
  end

  def edit
    @circle = Circle.find(params[:id])
  end
  def update
    @circle = Circle.find(params[:id])
    if @circle.update_attributes(circle_params)
      flash[:success] = "編集完了"
      redirect_to @circle
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def circle_params
      params.require(:circle).permit(
          :name,
          :description
        )
    end
end
