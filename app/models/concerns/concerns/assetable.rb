# module Assetable
module Assetable
  extend ActiveSupport::Concern
  # module ClassMethods
  class Meta
    def self.attributes
      %w[title alt external_url remove]
    end
  end

  included do
    validate :process_attachments
    validate :process_multiple_attachments
  end

  module ClassMethods
    def multiple_assets(*asset_arr)
      mattr_accessor :multiple_asset_names do
        asset_arr
      end
      asset_arr.each do |n|
        has_many n.to_sym, as: :assetable, class_name: 'Asset'
        s = n.to_s.singularize.to_sym
        attr_accessor "#{s}_attachment".to_sym
        Meta.attributes.each { |a| attr_accessor "#{s}_attachment_#{a}".to_sym }
      end
    end

    def single_asset(asset)
      single_assets asset
    end

    def single_assets(*asset_arr)
      mattr_accessor :single_asset_names do
        asset_arr
      end
      asset_arr.each do |n|
        belongs_to n.to_sym, optional: true, class_name: 'Asset'
        attr_accessor "#{n}_attachment".to_sym
        Meta.attributes.each { |a| attr_accessor "#{n}_attachment_#{a}".to_sym }
      end
    end
  end

  private

  def asset_attrs(t)
    {
      at: "#{t}_attachment".to_sym,
      alt: "#{t}_attachment_alt".to_sym,
      att: "#{t}_attachment_title".to_sym,
      atu: "#{t}_attachment_external_url".to_sym,
      atr: "#{t}_attachment_remove".to_sym
    }
  end

  def asset_hash(t)
    {
      attachment: send(asset_attrs(t)[:at]),
      title: send(asset_attrs(t)[:att]),
      alt: send(asset_attrs(t)[:alt]),
      external_url: send(asset_attrs(t)[:atu])
    }
  end

  def assetable_attrs
    {
      assetable_type: self.class.name,
      assetable_id: id
    }
  end

  def nillify_attrs(t)
    asset_attrs(t).each_value { |v| send("#{v}=", nil) }
  end

  def process_attachment(t, multiple = false) # rubocop:disable all
    return unless send(asset_attrs(t)[:at]) || send(asset_attrs(t)[:atu])
    a = Asset.new(asset_hash(t))
    if a.save
      if multiple
        send("#{t.to_s.pluralize}=", send(t.to_s.pluralize) + [a])
      else
        send("#{t}=", a)
      end
      nillify_attrs(t)
    else
      errors.add(t, a.errors.full_messages.join(','))
      false
    end
  end

  def process_attachments
    return unless respond_to?(:single_asset_names)
    single_asset_names.each { |t| process_attachment t }
  end

  def process_multiple_attachments
    return unless respond_to? :multiple_asset_names
    return if multiple_asset_names.blank?
    multiple_asset_names.map do |at|
      process_attachment at.to_s.singularize.to_sym, true
    end
  end
end
