class NotificationsController < ApplicationController
	before_action :set_notification, only: %i[ show ]

  def index
    @notifications = current_user.notifications.order(created_at: :DESC)
    @user_notifications = current_user.user_notifications.includes(notification: [:user]).order(created_at: :DESC)
  end

  def show
  end

  def new
    @notification = Notification.new
    @users = User.all
  end

  def create
    @notifications = current_user.notifications
    @notification = @notifications.find_by_tag(notification_params[:tag].downcase)
    if @notification.nil?
      @notification = @notifications.new(notification_params)
      unless @notification.save
        flash[:errors] = error_message!(@notification)
        return render :new, status: :unprocessable_entity
      end
    else
      @notification.update!(notification_params)
    end
    @notification ||= @notifications.create!(notification_params)
    @notification.create_receivers!(params[:notification][:receiver_id])
    redirect_to notifications_path, notice: "Notification was successfully created."    
  end

  def approved
    @notification = current_user.user_notifications.find(params[:id])
    @notification.update!(approved: true)
    redirect_to notifications_path, notice: "Notification was successfully approved."

  rescue Exception => e
    flash[:alert] = e.message
    redirect_to notifications_path, errors: e.message
  end

  def bulk_destroy
    @notifications = Notification.where(id: params[:ids])
    @notifications.destroy_all
    render json: {message: "Notification was successfully destroyed."}, status: :ok

  rescue Exception => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  private
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:notification).permit(:title, :content, :day, :tag, :importance )
    end
end