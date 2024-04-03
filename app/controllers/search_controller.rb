class SearchController < ApplicationController
  before_action :validate_presence_of_filter_params

  def index
    @calendar = TourAvailabilityCalendar.new(search_params[:start_date], search_params[:end_date]).call

    render json: @calendar
  end

  private

  def validate_presence_of_filter_params
    if search_params[:start_date].blank? || search_params[:end_date].blank?
      render json: { error: "Bad Request" }, status: 400
    end
  end

  def search_params
    params.require(:filter).permit(:start_date, :end_date)
  end
end
