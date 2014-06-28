class BreadcrumbBootstrap < SimpleNavigation::Renderer::Base
  def render(item_container)
=begin
    content_tag :ol, li_tags(item_container).join(join_with), {
      id: item_container.dom_id,
      class: "#{item_container.dom_class} breadcrumb"
    }
=end
    li_tags(item_container).join(join_with).html_safe
  end

  protected

  def li_tags(item_container)
    item_container.items.each_with_object([]) do |item, list|
      next unless item.selected?

      if include_sub_navigation?(item)
        options = { method: item.method }.merge(item.html_options.except(:class, :id, :opts))
        list << content_tag(:li, link_to(item.name, item.url), options)
        list.concat li_tags(item.sub_navigation)
      else
        list << content_tag(:li, item.name, { class: 'active' })
      end
    end
  end

  def join_with
    # @join_with ||= options[:join_with] || '<span class="divider">/</span>'.html_safe
    @join_with ||= options[:join_with] || ''
  end
end

=begin
使用例子
<ol class="breadcrumb">
  <li><a href="<%= back_root_path %>"><i class="fa fa-home"></i>主页</a></li>
  <%# render_navigation context: :admin, renderer: :breadcrumb_bootstrap_render %>
</ol>
=end
