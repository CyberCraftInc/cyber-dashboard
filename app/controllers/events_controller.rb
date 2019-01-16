class EventsController < ApplicationController
  before_action :set_event, only: %i[update destroy]

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.json { render json: { status: true } }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.json { render json: { status: true } }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.json
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:description, :start_date, :finish_date, :comments, :summary, :status)
  end
end
