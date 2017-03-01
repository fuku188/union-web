class EntriesController < ApplicationController

  before_action :authenticate_user!
  before_action :member_check, only: [:index, :accept]
  before_action :external_check, only: [:create, :destroy]

  def index
    @circle = Circle.find(params[:circle_id])
    @entries = @circle.entries

    @accept_btn = true
  end

  def create
    Entry.create(user_id: current_user.id, circle_id: params[:circle_id])
    flash[:success] = "申請完了"
    redirect_to controller: :circles, action: :show, id: params[:circle_id]
  end

  def destroy
    Entry.find(params[:id]).destroy
    flash[:success] = "キャンセルしました"
    redirect_to controller: :circles, action: :show, id: params[:circle_id]
  end

  def accept
    accepted_entry = Entry.find(params[:id])
    accepted_user  = User.find(accepted_entry.user_id)
    circle = Circle.find(params[:circle_id])
    circle.memberships.create(member_id: accepted_user.id)
    flash[:success] = "#{accepted_user.name}さんの加入を承認しました"
    accepted_entry.destroy
    redirect_to circle
  end

  private
    def member_check
      circle = Circle.find(params[:circle_id])
      unless circle.members.include?(current_user)
        flash[:failure] = "メンバーのみの機能です"
        redirect_to :root
      end
    end
    def external_check
      circle = Circle.find(params[:circle_id])
      if circle.members.include?(current_user)
        flash[:failure] = "メンバーではないユーザーのみの機能です"
        redirect_to :root
      end
    end
end
