class AppraisalFeesController < ApplicationController
  before_action :set_appraisal_fee, only: [:show, :edit, :update, :destroy]

  # GET /appraisal_fees
  # GET /appraisal_fees.json
  def index
    @appraisal_fees = AppraisalFee.all
  end

  # GET /appraisal_fees/1
  # GET /appraisal_fees/1.json
  def show
  end

  # GET /appraisal_fees/new
  def new
    @appraisal_fee = AppraisalFee.new
  end

  # GET /appraisal_fees/1/edit
  def edit
  end

  # POST /appraisal_fees
  # POST /appraisal_fees.json
  def create
    @appraisal_fee = AppraisalFee.new(appraisal_fee_params)
    @appraisal_fee.loan_id = session[:current_loan_id]

    respond_to do |format|
      if @appraisal_fee.save
        # format.html { redirect_to appraisal_fees_path, notice: 'Appraisal fee was successfully created.' }
        format.html { redirect_to Loan.find(@appraisal_fee.loan) }
        format.json { render action: 'show', status: :created, location: @appraisal_fee }
      else
        format.html { render action: 'new' }
        format.json { render json: @appraisal_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appraisal_fees/1
  # PATCH/PUT /appraisal_fees/1.json
  def update
    respond_to do |format|
      if @appraisal_fee.update(appraisal_fee_params)
        format.html { redirect_to appraisal_fees_path, notice: 'Appraisal fee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @appraisal_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appraisal_fees/1
  # DELETE /appraisal_fees/1.json
  def destroy
    @appraisal_fee.destroy
    respond_to do |format|
      format.html { redirect_to appraisal_fees_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appraisal_fee
      @appraisal_fee = AppraisalFee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appraisal_fee_params
      params.require(:appraisal_fee).permit(:duration_from, :duration_to, :percentual, :fixed_min, :fixed_max, :loan_id)
    end
end
