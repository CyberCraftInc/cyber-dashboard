class EventsController < ApplicationController
  before_action :set_event, only: %i[update destroy]

  # POST /events

  def create; end

  # PATCH/PUT /events/1

  def update; end

  # DELETE /events/1

  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.fetch(:event, {})
  end
end
