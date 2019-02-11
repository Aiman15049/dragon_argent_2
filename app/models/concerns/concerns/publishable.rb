module Publishable
  extend ActiveSupport::Concern

  included do
    include Workflow

    workflow do
      state :draft
      state :preview
      state :published
      state :archived
    end

    scope :live, (-> { where(workflow_state: :published) })

    def toggle_publish!
      update_attribute :workflow_state,
                       toggle_publish_hash[workflow_state.to_sym]
    end

    private

    def toggle_publish_hash
      {
        draft: :preview,
        preview: :published,
        published: :draft
      }
    end
  end
end
