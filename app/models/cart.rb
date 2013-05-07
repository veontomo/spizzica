class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy

  def add_item(item_id)
    current_item = self.line_items.find_by_item_id(item_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = self.line_items.build(:item_id => item_id)
    end
    current_item
  end
end