class Loan < ActiveRecord::Base
	belongs_to :bank
	belongs_to :loan_type
	has_many :interest_rates
	has_many :appraisal_fees
	has_many :insurance_fees
end
