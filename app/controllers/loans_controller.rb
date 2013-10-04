class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy]

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
    @loans = []
    Loan.where("loan_type_id = ?", params[:loan_type_id]).each do |loan|
      payment = loan.calculate_payment(params[:principal].to_i, params[:duration].to_i, fixed)      
      @loans << "#{loan.bank.name}: #{payment.round(2)}" if payment
    end

    # render :text => "<h1>Mesecni obrok</h1>" + @loans.join("<br/>")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:name, :bank_id, :loan_type_id)
    end
end
