class NormalListingPaginate < WillPaginate::ViewHelpers::LinkRenderer

  # include Wps::WpsLinkHelper

  def to_html
    links = @options[:page_links] ? windowed_links : []

    links.unshift(page_link_or_span(@collection.previous_page, 'previous', @options[:previous_label].html_safe))
    links.push(page_link_or_span(@collection.next_page, 'next', @options[:next_label].html_safe))

    html = links.join(@options[:separator])
    @options[:container] ? @template.content_tag(:ul, html.html_safe, html_attributes) : html
  end

  protected

  def page_number(page)
    unless page == current_page
      tag(:li, link(page, page, :rel => rel_value(page)))
    else
      tag(:li, page, :class => "current")
    end
  end

  def previous_or_next_page(page, text, classname)
    if page
      tag(:li, link(text, page), :class => classname)
    else
      tag(:li, text, :class => classname + ' disabled')
    end
  end
  def gap
      tag(:li, "...", :class => "gap")
  end
  def html_container(html)
    tag(:ul, html, container_attributes)
  end

  def windowed_links
    windowed_page_numbers.map { |n| page_link_or_span(n, (n == current_page ? 'current' : nil)) }
  end

  def page_link_or_span(page, span_class, text = nil)
    text ||= page.to_s
    if page && page != current_page
      page_link(page, text, {:class => span_class}, {:rel => custom_rel_value(page)})
    else
      page_span(page, text, :class => span_class)
    end
  end

  def custom_rel_value(page)
    case page
      when @collection.previous_page; 'prev' + (page == 1 ? ' start' : '')
      when @collection.next_page; 'next'
      when 1; 'start'
    end
  end

   def page_link(page, text, attributes = {}, link_options={})
    unless text == "gap"
      if page == 1
        @template.content_tag(:li, @template.link_to(text, @template.get_normal_listing_for_will_paginate({}).split("/").join("/"), link_options), attributes)
      else
        @template.content_tag(:li, @template.link_to(text,  @template.get_normal_listing_for_will_paginate({:page => page}) , link_options), attributes)
      end
      else
        gap
    end
  end

  def page_span(page, text, attributes = {})
    @template.content_tag(:li, text, attributes)
  end

  def html_attributes
    return @html_attributes if @html_attributes
    @html_attributes = @options.except *(WillPaginate::ViewHelpers.pagination_options.keys - [:class])
    # pagination of Post models will have the ID of "posts_pagination"
    if @options[:container] and @options[:id] === true
      @html_attributes[:id] = @collection.first.class.name.underscore.pluralize + '_pagination'
    end
    @html_attributes
  end

end

