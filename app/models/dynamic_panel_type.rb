class DynamicPanelType < ApplicationRecord
  has_many :dynamic_panels, dependent: :destroy

  validates :title, presence: true
end
