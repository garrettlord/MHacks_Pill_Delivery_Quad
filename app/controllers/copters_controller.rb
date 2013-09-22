class CoptersController < ApplicationController
  before_action :set_copter, only: [:show, :edit, :update, :destroy]

  # GET /copters
  # GET /copters.json
  def index
    @copters = Copter.all
  end

  # GET /copters/1
  # GET /copters/1.json
  def show
  end

  # GET /copters/new
  def new
    @copter = Copter.new
  end

  # GET /copters/1/edit
  def edit
  end

  # POST /copters
  # POST /copters.json
  def create
    @copter = Copter.new(copter_params)

    respond_to do |format|
      if @copter.save
        format.html { redirect_to @copter, notice: 'Copter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @copter }
      else
        format.html { render action: 'new' }
        format.json { render json: @copter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /copters/1
  # PATCH/PUT /copters/1.json
  def update
    respond_to do |format|
      if @copter.update(copter_params)
        format.html { redirect_to @copter, notice: 'Copter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @copter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /copters/1
  # DELETE /copters/1.json
  def destroy
    @copter.destroy
    respond_to do |format|
      format.html { redirect_to copters_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_copter
      @copter = Copter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def copter_params
      params.require(:copter).permit(:hospital_id, :name, :category, :last_latitude, :last_longitude, :available)
    end
end
