class DynamicPanel < ApplicationRecord
  belongs_to :dynamic_page
  belongs_to :dynamic_panel_type
end
