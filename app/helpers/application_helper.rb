# frozen_string_literal: true

module ApplicationHelper
  def asset_pack_path(name, **options)
    path = super(name)
    return path if path

    asset_path(Webpacker.manifest.lookup!(name), **options)
  end

  def image_pack_tag(name, **options)
    return image_tag path, **options unless name =~ /.(jpe?g|png)/

    path = asset_path(Webpacker.manifest.lookup!(name), **options)
    picture_tag(path_webp, path, options).html_safe
  end

  private

  def picture_tag(webpacker_manifest_path, path, options)
    '<picture>' /
      "<source srcset='#{webpacker_manifest_path}' type='image/webp'>" /
      "  <source srcset='#{path}' type='image/jpeg'>" /
      "  #{image_tag path, **options}" /
      '</picture>'.html_safe
  end

  def webpacker_manifest_path(name, options)
    asset_path(Webpacker.manifest
                        .lookup!(name.gsub(/.(jpe?g|png)/,
                                           '.webp')), **options)
  end
end
