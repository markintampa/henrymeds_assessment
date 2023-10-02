class AppointmentSlotsController < ApplicationController
  before_action :set_appointment_slot, only: [:show, :update, :destroy, "confirm"]
  before_action :set_client, only: [:update, "confirm"]

  # GET /appointment_slots
  def index
    @appointment_slots = AppointmentSlot.where("start_time > ?", Time.now + 24.hours).where(reserved_at: nil, confirmed: nil).all
    @appointment_slots += AppointmentSlot.where("start_time > ?", Time.now + 24.hours).where("reserved_at < ?", 30.minutes.ago).where(confirmed: nil).all
    render json: @appointment_slots
  end

  # GET /appointment_slots/1
  def show
    render json: @appointment_slot
  end

  # POST /appointment_slots
  def create
    time = Time.parse(appointment_slot_params[:start_time])
    end_time = Time.parse(appointment_slot_params[:end_time])
    @appointment_slots = []

    while time < end_time do
      @appointment_slots << AppointmentSlot.create(
          provider_id: appointment_slot_params[:provider_id],
          start_time: time,
          created_at: Time.now,
          updated_at: Time.now
        )
        time += 15.minutes
    end

    #TODO - Add in error handling and response.

    render status: :ok
  end

  # PATCH/PUT /appointment_slots/1
  def update
    if slot_available(@appointment_slot)
      @appointment_slot.update({
        reserved_by: @client.id,
        client_id: @client.id,
        reserved_at: Time.now
      })
      render json: @appointment_slot, status: :ok
    else
      render json: @appointment_slot, status: :unprocessable_entity
    end
  end

  #PUT /appointment_slots/1/confirm
  def confirm
    if @appointment_slot.reserved_at != nil && @appointment_slot.reserved_at > 30.minutes.ago && @appointment_slot.reserved_by.to_i == @client.id
      @appointment_slot.update(confirmed: true)
      render json: @appointment_slot, status: :ok
    else
      render json: @appointment_slot, status: :unprocessable_entity
    end
  end

  # DELETE /appointment_slots/1
  def destroy
    @appointment_slot.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment_slot
      @appointment_slot = AppointmentSlot.find(params[:id])
    end

    def set_client
      @client = Client.find(params[:client_id])
    end

    def slot_available(slot)
      slot.start_time >= 24.hours.from_now &&
      slot.confirmed != true &&
      (slot.reserved_at == nil || (slot.reserved_at < 30.minutes.ago))
    end

    # Only allow a list of trusted parameters through.
    def appointment_slot_params
      params.require(:appointment_slot).permit(:provider_id, :client_id, :start_time, :end_time, :reserved_at, :reserved_by, :confirmed)
    end
end
