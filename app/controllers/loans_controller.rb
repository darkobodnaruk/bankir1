# encoding: UTF-8

class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_user!, :only => [:comparison, :comparison_results]

  # GET /loans
  # GET /loans.json
  def index
    @loans = Loan.all
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
    session["current_loan_id"] = @loan.id
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    logger.debug "!! create"
    loan_params
    @loan = Loan.new(loan_params)
    # logger.debug loan_params

    respond_to do |format|
      if @loan.save
        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @loan }
      else
        format.html { render action: 'new' }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url }
      format.json { head :no_content }
    end
  end

  def comparison
  end

  def comparison_results
    fixed = false
    principal = params[:principal].to_i
    duration = params[:duration].to_i

    if duration > 360
      flash[:notice] = "Trajanje ne sme biti daljše od 360 mesecev."
      redirect_to :action => :comparison
      return
    end
    if params[:loan_type_id] == 0
      flash[:notice] = "Izbrati morate tip kredita."
      redirect_to :action => :comparison
      return
    end
    if principal == 0
      flash[:notice] = "Glavnica mora biti numerična."
      redirect_to :action => :comparison
      return
    else
      logger.debug("principal: " + principal.to_s)
    end

    logger.debug("proceeding")
    
    @best_loans = []
    Loan.where("loan_type_id = ?", params[:loan_type_id]).each do |loan|
      # strosek odobritve
      appraisal_fee = loan.appraisal_fees.first
      if appraisal_fee
        appraisal_cost = appraisal_fee.percentual / 100 * principal
        appraisal_cost = appraisal_fee.fixed_min if appraisal_cost < appraisal_fee.fixed_min
        appraisal_cost = appraisal_fee.fixed_max if appraisal_cost > appraisal_fee.fixed_max
      else
        appraisal_cost = 0
      end

      # strosek zavarovanja
      insurance_fee = loan.insurance_fees.first
      if insurance_fee
        insurance_cost = insurance_fee.percentual / 100 * principal
        insurance_cost = insurance_fee.fixed_min if insurance_cost < insurance_fee.fixed_min
        insurance_cost = insurance_fee.fixed_max if insurance_cost > insurance_fee.fixed_max
      else
        insurance_cost = 0
      end

      costs = appraisal_cost + insurance_cost

      # calculate payment
      payment, ref_rate, interest_rate = loan.calculate_payment(principal, duration, fixed)

      # calculate IRR - it's CPU expensive, calculate it later, only for the top 3 loans
      # if payment
      #   eom = loan.calculate_eom(principal, costs, payment, duration, Time.new)
      # end

      if payment
        @best_loans << {
          :loan => loan, 
          :payment => payment.round(2), 
          :eom => nil,
          :costs => costs,
          :duration => duration, 
          :principal => principal,
          :costs => costs,
          :total_cost => (costs + duration * payment - principal).round(2), 
          :interest_rate => interest_rate, 
          :ref_rate => ref_rate,
          :ref_rate_name => loan.reference_rate
        }
      end
    end

    # select top 3
    @best_loans = @best_loans.sort!{|x,y| x[:total_cost] <=> y[:total_cost]}.take(3)

    # calculate EOM
    @best_loans.each do |loan|
      loan[:eom] = Loan.calculate_eom(loan[:principal], loan[:costs], loan[:payment], loan[:duration], Time.new).round(2)
    end

    @duration = duration
    @principal = principal
  end

  def change_theme
    @session[:theme] = params[:name]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:name, :bank_id, :loan_type_id, :reference_rate)
    end
end
