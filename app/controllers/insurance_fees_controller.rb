class InsuranceFeesController < ApplicationController
  before_action :set_insurance_fee, only: [:show, :edit, :update, :destroy]

  # GET /insurance_fees
  # GET /insurance_fees.json
  def index
    @insurance_fees = InsuranceFee.all
  end

  # GET /insurance_fees/1
  # GET /insurance_fees/1.json
  def show
  end

  # GET /insurance_fees/new
  def new
    @insurance_fee = InsuranceFee.new
  end

  # GET /insurance_fees/1/edit
  def edit
  end

  # POST /insurance_fees
  # POST /insurance_fees.json
  def create
    @insurance_fee = InsuranceFee.new(insurance_fee_params)
    @insurance_fee.loan_id = session[:current_loan_id]

    respond_to do |format|
      if @insurance_fee.save
        # format.html { redirect_to @insurance_fee, notice: 'Insurance fee was successfully created.' }
        format.html { redirect_to Loan.find(@insurance_fee.loan_id) }
        format.json { render action: 'show', status: :created, location: @insurance_fee }
      else
        format.html { render action: 'new' }
        format.json { render json: @insurance_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurance_fees/1
  # PATCH/PUT /insurance_fees/1.json
  def update
    respond_to do |format|
      if @insurance_fee.update(insurance_fee_params)
        format.html { redirect_to @insurance_fee, notice: 'Insurance fee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @insurance_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_fees/1
  # DELETE /insurance_fees/1.json
  def destroy
    @insurance_fee.destroy
    respond_to do |format|
      format.html { redirect_to insurance_fees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance_fee
      @insurance_fee = InsuranceFee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insurance_fee_params
      params.require(:insurance_fee).permit(:duration_from, :duration_to, :percentual)
    end
end
