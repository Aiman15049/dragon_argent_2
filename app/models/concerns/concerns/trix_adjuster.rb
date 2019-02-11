module TrixAdjuster
  extend ActiveSupport::Concern

  included do
    validate :remove_trix_divs
  end

  private

  def remove_trix_divs
    return if trix_fields.blank?
    trix_fields.each { |field| remove_trix_divs_from field }
  end

  def remove_trix_divs_from(field)
    return unless respond_to? field
    return if send(field).blank?
    send("#{field}=", send(field).gsub(/^<div>/, '')
                                 .gsub(%r{</div>$}, ''))
  end

  def trix_fields
    []
  end
end
