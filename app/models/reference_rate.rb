require 'rubygems'
require 'wombat'

class ReferenceRate < ActiveRecord::Base
	def self.fetch_rates
		r = Wombat.crawl do
			base_url 'http://www.euribor-ebf.eu'
			path '/euribor-org/euribor-rates.html'
			three_month 'xpath=//table[@id="report_ajax"]//tr[12]/td[2]'
			six_month 'xpath=//table[@id="report_ajax"]//tr[18]/td[2]'
			twelve_month 'xpath=//table[@id="report_ajax"]//tr[30]/td[2]'
		end

		regex = /^([\.\d]+).*\((.+)\)/

		if r["three_month"] =~ regex
			parse_td_and_update("EURIBOR3", $2, $1)
		end

		if r["six_month"] =~ regex
			parse_td_and_update("EURIBOR6", $2, $1)
		end

		if r["twelve_month"] =~ regex
			parse_td_and_update("EURIBOR12", $2, $1)
		end
	end

private
	def self.parse_td_and_update(name, date, rate)
		dt = DateTime.parse(date, "%m/%d/%Y").to_date
		r = find_or_initialize_by(:date => dt, :name => name)
		r.update_attributes(:rate => rate.to_f)
	end
end
