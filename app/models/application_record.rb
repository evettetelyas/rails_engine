class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    pluck(:id).sample(1).join
  end

end
