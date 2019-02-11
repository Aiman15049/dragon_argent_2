class DynamicPage < ApplicationRecord
  has_many :dynamic_panels, dependent: :destroy
  has_ancestry
  has_many :carousel_items, dependent: :destroy

  has_and_belongs_to_many :downloadable_categories
  has_and_belongs_to_many :eventbrite_categories

  acts_as_list scope: %i[ancestry], add_new_at: :bottom
  include Assetable
  single_assets :asset

  include HttpAble
  include Ownable
  include Publishable
  extend FriendlyId


  STATIC_DESCRIPTOR_HOME = "home".freeze
  STATIC_DESCRIPTORS = [STATIC_DESCRIPTOR_HOME].freeze

  def home?
    static_descriptor == STATIC_DESCRIPTOR_HOME
  end

  def possible_parents
    return self.class.none if home? || !owner
    return owner.dynamic_pages if new_record?
    owner.dynamic_pages.where.not(id: self_and_descendant_ids)
  end

  def descriptor
    return static_descriptor.humanize if static_descriptor
    return page_type.humanize if page_type
    ''
  end



end
