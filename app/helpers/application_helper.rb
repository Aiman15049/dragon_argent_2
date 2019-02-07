# frozen_string_literal: true

module ApplicationHelper
  def asset_pack_path(name, **options)
    path = super(name)
    return path if path

    asset_path(Webpacker.manifest.lookup!(name), **options)
  end

  def image_pack_tag(name, **options)
    unless name =~ /.(jpe?g|png)/
      return image_tag webpacker_manifest_path(name, options), **options
    end

    picture_tag(name, options).html_safe
  end

  private

  def picture_tag(name, options)
    path = webpacker_manifest_path(name, options)
    '<picture>' \
      "<source srcset='#{webp_path(name, options)}' type='image/webp'>" \
      "  <source srcset='#{path}' type='image/jpeg'>" \
      "  #{image_tag path, **options}" \
      '</picture>'.html_safe
  end

  def webp_path(name, options)
    webpacker_manifest_path(name.gsub(/.(jpe?g|png)/, '.webp'), options)
  end

  def webpacker_manifest_path(name, options)
    asset_path(Webpacker.manifest
                        .lookup!(name), **options)
  end
end
