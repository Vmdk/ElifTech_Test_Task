class Company < ActiveRecord::Base
  # helper CompaniesHelper
  has_many :child_companies, :class_name => "Company", :foreign_key => "master_company_id"
  belongs_to :master_company, :class_name => "Company"
end
