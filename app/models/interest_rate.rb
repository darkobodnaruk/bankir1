class InterestRate < ActiveRecord::Base
	belongs_to :loan
	
	# scope :fixed, :conditions => {:fixed => true}
	scope :fixed, -> { where(:fixed => true) }
	# scope :variable, :conditions => {:fixed => false}
	scope :variable, -> { where(:fixed => false) }
end
