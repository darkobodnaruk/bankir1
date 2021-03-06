class LoanTypesController < ApplicationController
  before_action :set_loan_type, only: [:show, :edit, :update, :destroy]

  # GET /loan_types
  # GET /loan_types.json
  def index
    @loan_types = LoanType.all
  end

  # GET /loan_types/1
  # GET /loan_types/1.json
  def show
  end

  # GET /loan_types/new
  def new
    @loan_type = LoanType.new
  end

  # GET /loan_types/1/edit
  def edit
  end

  # POST /loan_types
  # POST /loan_types.json
  def create
    @loan_type = LoanType.new(loan_type_params)

    respond_to do |format|
      if @loan_type.save
        format.html { redirect_to @loan_type, notice: 'Loan type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @loan_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @loan_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loan_types/1
  # PATCH/PUT /loan_types/1.json
  def update
    respond_to do |format|
      if @loan_type.update(loan_type_params)
        format.html { redirect_to @loan_type, notice: 'Loan type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @loan_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loan_types/1
  # DELETE /loan_types/1.json
  def destroy
    @loan_type.destroy
    respond_to do |format|
      format.html { redirect_to loan_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan_type
      @loan_type = LoanType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_type_params
      params.require(:loan_type).permit(:name)
    end
end
