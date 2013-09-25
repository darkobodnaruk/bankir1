class InterestRate < ActiveRecord::Base
	belongs_to :loan
	
	scope :fixed, :conditions => {:fixed => true}
	scope :variable, :conditions => {:fixed => false}
end
