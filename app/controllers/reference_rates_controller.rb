class ReferenceRatesController < ApplicationController
  before_action :set_reference_rate, only: [:show, :edit, :update, :destroy]

  # GET /reference_rates
  # GET /reference_rates.json
  def index
    @reference_rates = ReferenceRate.all
  end

  # GET /reference_rates/1
  # GET /reference_rates/1.json
  def show
  end

  # GET /reference_rates/new
  def new
    @reference_rate = ReferenceRate.new
  end

  # GET /reference_rates/1/edit
  def edit
  end

  # POST /reference_rates
  # POST /reference_rates.json
  def create
    @reference_rate = ReferenceRate.new(reference_rate_params)

    respond_to do |format|
      if @reference_rate.save
        format.html { redirect_to @reference_rate, notice: 'Reference rate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @reference_rate }
      else
        format.html { render action: 'new' }
        format.json { render json: @reference_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reference_rates/1
  # PATCH/PUT /reference_rates/1.json
  def update
    respond_to do |format|
      if @reference_rate.update(reference_rate_params)
        format.html { redirect_to @reference_rate, notice: 'Reference rate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reference_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reference_rates/1
  # DELETE /reference_rates/1.json
  def destroy
    @reference_rate.destroy
    respond_to do |format|
      format.html { redirect_to reference_rates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference_rate
      @reference_rate = ReferenceRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_rate_params
      params.require(:reference_rate).permit(:name, :rate)
    end
end
