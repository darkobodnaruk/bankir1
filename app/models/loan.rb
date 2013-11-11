include Finance
class Loan < ActiveRecord::Base
	belongs_to :bank
	belongs_to :loan_type
	has_many :interest_rates, :dependent => :destroy
	has_many :appraisal_fees, :dependent => :destroy
	has_many :insurance_fees, :dependent => :destroy

	# CALC_METHOD = :orig
	CALC_METHOD = :priporocila_bs_anuitetni
	# CALC_METHOD = :priporocila_bs_obrocni

	def calculate_payment(principal, duration, fixed)
		# TODO: fetch the right ref. rate for duration
		if not fixed
			# reference_rate = ReferenceRate.last.rate
			# rrate = ReferenceRate.find_by(:name => reference_rate).last.rate
			rrate = ReferenceRate.where(:name => reference_rate).last.rate
		else
			rrate = 0
		end

		# logger.debug ">>>>> rrate: #{rrate}"

		interest_rate = interest_rates.where("duration_from <= ? and duration_to >= ? and fixed = ?", duration, duration, fixed).first
		if interest_rate
			rate = (interest_rate.rate + rrate)
			
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

			# logger.debug ">>>>> rate: #{rate}"
			# logger.debug ">>>>> obdobni_obrestovalni_faktor: #{obdobni_obrestovalni_faktor}"
			# logger.debug ">>>>> duration: #{duration}"
			# logger.debug ">>>>> principal: #{principal}"
			# logger.debug ">>>>> payment: #{payment}"
			# logger.debug ">>>>> " + (Time.now - t1).to_s + " seconds"

			return payment, rrate, interest_rate.rate
		else
			nil
		end
	end

	# def calculate_eom(principal, costs, payment, num_of_periods, start_dt)
	def self.calculate_eom(principal, costs, payment, num_of_periods, start_dt)
		logger.debug costs
		transactions = []
		transactions << Transaction.new(principal - costs, :date => start_dt)
		dt = start_dt
		(1..num_of_periods).each do |i|
			dt += 1.month
			transactions << Transaction.new(-1 * payment, :date => dt)
		end

		t1 = Time.now
		eom = transactions.xirr.apr.to_f.round(4) * 100
		logger.debug (Time.now - t1).to_s + " seconds for xirr of #{num_of_periods} transactions"
		return eom
	end
end
