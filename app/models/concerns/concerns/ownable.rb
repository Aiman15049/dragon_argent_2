
# Ownable
module Ownable
  extend ActiveSupport::Concern

  included do
    belongs_to :owner, polymorphic: true
  end

  module ClassMethods
    def owned_by(owner = nil)
      return self unless owner
      where(owner: owner)
    end
  end
end
