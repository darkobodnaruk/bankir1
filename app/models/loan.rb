class Loan < ActiveRecord::Base
	belongs_to :bank
	belongs_to :loan_type
	has_many :interest_rates
	has_many :appraisal_fees
	has_many :insurance_fees

	def calculate_payment(principal, duration, fixed)
		# TODO: fetch the right ref. rate for duration
		if not fixed
			reference_rate = ReferenceRate.last.rate
		else
			reference_rate = 0
		end

		interest_rate = interest_rates.where("duration_from <= ? and duration_to >= ? and fixed = ?", duration, duration, fixed).first
		if interest_rate
			rate = interest_rate.rate + reference_rate
			rate = rate / 100 / 12
			payment = principal * (rate / (1 - (1 + rate) ** (-duration)))
		else
			nil
		end
	end
end
