class EventsController < ApplicationController
  before_action :set_event, only: %i[update destroy]

  def create
    @event = Event.new(event_params)
    authorize @event
    respond_to do |format|
      if @event.save
        send_email_create_event
        format.json { render json: { status: :created } }
      else
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @event
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
    params.require(:event).permit(:description, :status, :start_date, :finish_date,
                                  :comments, :summary, :user_id,
                                  targets_attributes: %i[id description achieved _destroy])
  end

  def send_email_create_event
    EventMailer.with(event: @event, author: current_user).create_event.deliver_now
  end
end
