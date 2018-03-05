class Tag < ActiveRecord::Base
  validates :name, :code, presence: true
  validates_uniqueness_of :name, :code
end
