class Loan < ActiveRecord::Base
	belongs_to :bank
	belongs_to :loan_type
end
