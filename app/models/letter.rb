class Letter < ActiveRecord::Base
  def is_draft?
    self.text.include?('draft')
  end
end
