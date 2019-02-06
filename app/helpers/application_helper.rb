# frozen_string_literal: true

module ApplicationHelper
   def asset_pack_path(name, **options)
    path = super(name)
    return path if path

    asset_path(Webpacker.manifest.lookup!(name), **options)
  end

  def image_pack_tag(name, **options)
    path = asset_path(Webpacker.manifest.lookup!(name), **options)
    if name.match(/.(jpe?g|png)/) 
      pathWebp = asset_path(Webpacker.manifest.lookup!(name.gsub(/.(jpe?g|png)/, '.webp')), **options)
      return "<picture>
        <source srcset='#{pathWebp}' type='image/webp'>
        <source srcset='#{path}' type='image/jpeg'> 
        #{image_tag path, **options}
      </picture>".html_safe
    end

    return image_tag path, **options
  end
    
end
