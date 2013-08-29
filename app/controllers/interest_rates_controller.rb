class InterestRatesController < ApplicationController
  before_action :set_interest_rate, only: [:show, :edit, :update, :destroy]

  # GET /interest_rates
  # GET /interest_rates.json
  def index
    @interest_rates = InterestRate.all
  end

  # GET /interest_rates/1
  # GET /interest_rates/1.json
  def show
  end

  # GET /interest_rates/new
  def new
    @interest_rate = InterestRate.new
  end

  # GET /interest_rates/1/edit
  def edit
    logger.debug "interest_rate: #{@interest_rate.id}, #{@interest_rate.loan_id}"
  end

  # POST /interest_rates
  # POST /interest_rates.json
  def create
    @interest_rate = InterestRate.new(interest_rate_params)

    respond_to do |format|
      if @interest_rate.save
        # format.html { redirect_to @interest_rate, notice: 'Interest rate was successfully created.' }
        format.html { redirect_to interest_rates_path, notice: 'Interest rate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @interest_rate }
      else
        format.html { render action: 'new' }
        format.json { render json: @interest_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interest_rates/1
  # PATCH/PUT /interest_rates/1.json
  def update
    respond_to do |format|
      if @interest_rate.update(interest_rate_params)
        # format.html { redirect_to @interest_rate, notice: 'Interest rate was successfully updated.' }
        format.html { redirect_to interest_rates_path, notice: 'Interest rate was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @interest_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interest_rates/1
  # DELETE /interest_rates/1.json
  def destroy
    @interest_rate.destroy
    respond_to do |format|
      format.html { redirect_to interest_rates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest_rate
      @interest_rate = InterestRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interest_rate_params
      params.require(:interest_rate).permit(:fixed, :duration_from, :duration_to, :bank_customer, :insured, :rate, :loan_id)
    end
end
