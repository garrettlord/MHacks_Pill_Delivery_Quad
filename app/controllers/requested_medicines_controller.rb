class RequestedMedicinesController < ApplicationController
  before_action :set_requested_medicine, only: [:show, :edit, :update, :destroy]

  # GET /requested_medicines
  # GET /requested_medicines.json
  def index
    @requested_medicines = RequestedMedicine.all
  end

  # GET /requested_medicines/1
  # GET /requested_medicines/1.json
  def show
  end

  # GET /requested_medicines/new
  def new
    @requested_medicine = RequestedMedicine.new
  end

  # GET /requested_medicines/1/edit
  def edit
  end

  # POST /requested_medicines
  # POST /requested_medicines.json
  def create
    @requested_medicine = RequestedMedicine.new(requested_medicine_params)

    respond_to do |format|
      if @requested_medicine.save
        format.html { redirect_to @requested_medicine, notice: 'Requested medicine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @requested_medicine }
      else
        format.html { render action: 'new' }
        format.json { render json: @requested_medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requested_medicines/1
  # PATCH/PUT /requested_medicines/1.json
  def update
    respond_to do |format|
      if @requested_medicine.update(requested_medicine_params)
        format.html { redirect_to @requested_medicine, notice: 'Requested medicine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @requested_medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requested_medicines/1
  # DELETE /requested_medicines/1.json
  def destroy
    @requested_medicine.destroy
    respond_to do |format|
      format.html { redirect_to requested_medicines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requested_medicine
      @requested_medicine = RequestedMedicine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requested_medicine_params
      params.require(:requested_medicine).permit(:request_id, :medicine_id, :quantity)
    end
end
