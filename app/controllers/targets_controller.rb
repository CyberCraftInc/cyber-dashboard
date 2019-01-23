class TargetsController < ApplicationController
  before_action :set_target, only: %i[update destroy toggle_achieved]

  def create
    @target = Target.new(target_params)

    respond_to do |format|
      if @target.save
        format.json { render json: { status: true } }
      else
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @target.update(target_params)
        format.json { render json: { status: true } }
      else
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @target.destroy
    respond_to do |format|
      format.json
    end
  end

  def toggle_achieved
    @target.achieved = !@target.achieved
    respond_to do |format|
      if @target.save
        format.json { render status: :ok, json: { status: true } }
      else
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_target
    @target = Target.find(params[:id])
  end

  def target_params
    params.require(:event).permit(:description, :achieved)
  end
end
