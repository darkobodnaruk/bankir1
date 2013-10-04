#!/usr/bin/ruby

require 'rubygems'
require 'wombat'

r = Wombat.crawl do
	base_url 'http://www.euribor-ebf.eu'
	path '/euribor-org/euribor-rates.html'
	elem 'xpath=//table[@id="report_ajax"]//tr[30]/td[2]'
end

#puts r
#puts r["elem"]
#puts r["elem"].gsub!(/^([\.\d]*)\s.*$/, '\1')

if r["elem"] =~ /^([\.\d]+)/
	puts $1
end
