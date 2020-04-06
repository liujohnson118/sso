class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def archive!
    self.update(archived: true)
  end
end
