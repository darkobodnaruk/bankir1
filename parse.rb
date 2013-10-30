#!/usr/bin/ruby

require 'rubygems'
require 'wombat'

r = Wombat.crawl do
	base_url 'http://www.euribor-ebf.eu'
	path '/euribor-org/euribor-rates.html'
	three_month 'xpath=//table[@id="report_ajax"]//tr[12]/td[2]'
	six_month 'xpath=//table[@id="report_ajax"]//tr[18]/td[2]'
	twelve_month 'xpath=//table[@id="report_ajax"]//tr[30]/td[2]'
end

regex = /^([\.\d]+).*\((.+)\)/

if r["three_month"] =~ regex
	puts $1
	puts $2
end

if r["six_month"] =~ regex
	puts $1
	puts $2
end

if r["twelve_month"] =~ regex
	puts $1
	puts $2
end
