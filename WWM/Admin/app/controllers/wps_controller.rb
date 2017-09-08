class WpsController < ApplicationController
 def sr_page_cache
    logger.info "cache ---- #{allow_caching?} ---- #{Rails.env.production?} ---- #{@site.config.cache.cache} ---- #{@site.config.cache.page_cache} ---- #{response.status.to_s}"
    expires_in = @page_properties ? (eval(@page_properties[:expires_in].to_s).blank? ? ExpiresIn : eval(@page_properties[:expires_in].to_s)) : ExpiresIn
    expires_in expires_in, :public => true if allow_caching?
    response.headers["x-browser-cache"] = "max-age=#{SR_PAGE_CACHE_MAX_AGE}, public"
  end
end
