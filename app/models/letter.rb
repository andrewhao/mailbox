class Letter < ActiveRecord::Base
  def is_draft?
    self.subject ? self.subject.include?('draft') : false
  end
end
