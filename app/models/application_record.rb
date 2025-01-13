# Application Record is an abstract class to represent necessary features of the different types of records
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
