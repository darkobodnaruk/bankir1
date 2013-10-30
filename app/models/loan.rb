class Loan < ActiveRecord::Base
	belongs_to :bank
	belongs_to :loan_type
	belongs_to :reference_rate
	has_many :interest_rates
	has_many :appraisal_fees
	has_many :insurance_fees

	# CALC_METHOD = :orig
	CALC_METHOD = :priporocila_bs_anuitetni
	# CALC_METHOD = :priporocila_bs_obrocni

	def calculate_payment(principal, duration, fixed)
		# TODO: fetch the right ref. rate for duration
		if not fixed
			reference_rate = ReferenceRate.last.rate
		else
			reference_rate = 0
		end

		logger.debug ">>>>> reference_rate: #{reference_rate}"

		interest_rate = interest_rates.where("duration_from <= ? and duration_to >= ? and fixed = ?", duration, duration, fixed).first
		if interest_rate
			rate = (interest_rate.rate + reference_rate)
			
			logger.debug ">>>>> rate: #{rate}"
			
			if CALC_METHOD == :orig
				rate = rate / 100 / 12
				payment = principal * (rate / (1 - (1 + rate) ** (-duration)))
			elsif CALC_METHOD == :priporocila_bs_anuitetni
				obdobni_obrestovalni_faktor = 1 + (rate / (12 * 100))
				payment = principal * ((obdobni_obrestovalni_faktor ** duration) * (obdobni_obrestovalni_faktor - 1) / (obdobni_obrestovalni_faktor ** duration - 1))
			elsif CALC_METHOD == :priporocila_bs_obrocni
				# nothing
			end

			logger.debug ">>>>> rate: #{rate}"
			logger.debug ">>>>> obdobni_obrestovalni_faktor: #{obdobni_obrestovalni_faktor}"
			logger.debug ">>>>> duration: #{duration}"
			logger.debug ">>>>> principal: #{principal}"
			logger.debug ">>>>> payment: #{payment}"

			return payment
		else
			nil
		end
	end
end
