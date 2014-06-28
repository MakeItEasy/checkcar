## https://gist.github.com/jalberto/2402087
class ListBootstrap < SimpleNavigation::Renderer::Base
  def render(item_container)
    li_tags(item_container).join.html_safe
  end
 
private
  def li_tags(item_container)
    result_list = item_container.items.inject([]) do |list, item|
      if item.html_options[:opts]
        if item.html_options[:opts][:nav_header]
          list << li_header(item)
        elsif item.html_options[:opts][:icon]
          list << li_icon(item, item_container)
        else
          list << li_tag(item, item_container)
        end
      else
        list << li_tag(item, item_container)
      end
    end
    result_list
  end
 
  def li_tag(item, item_container)
    classes = item.selected? ? 'active' : nil
    if item.sub_navigation
      sub_menu_content = content_tag(:ul, li_tags(item.sub_navigation).join.html_safe,
                                     class: 'treeview-menu', style: 'display: none;')
      # 包含子菜单
      content_tag(:li, link_to(item.name, nil) + sub_menu_content, { class: 'treeview ' + classes })
    else
      icon_classes = (item_container.level_for_item(item.key) == 1 ? '' : 'fa fa-angle-double-right' )
      if item_container.level_for_item(item.key) == 1
        # 顶级菜单
        content_tag(:li, link_to(item.name, item.url, {:method => item.method}.merge(item.html_options.except(:class,:id,:opts))), { class: classes })
      else
        # 如果是子菜单,那么要在前面显示缩进
        content_tag(:li, 
          content_tag(:a, content_tag(:i, nil, class: 'fa fa-angle-double-right') + ' ' +
            content_tag(:span, item.name),
              {:href => item.url, :method => item.method}.merge(item.html_options.except(:class,:id,:opts))),
              { class: classes })
      end
    end
  end
 
  def li_header(item)
    content_tag(:li, item.name, { class: 'nav-header' }.merge(item.html_options.except(:class,:id,:opts)))
  end
 
  def li_icon(item, item_container)
    classes = item.selected? ? 'active' : ''
    # if include_sub_navigation?(item)
    if item.sub_navigation
      sub_menu_content = content_tag(:ul, li_tags(item.sub_navigation).join.html_safe,
                                     class: 'treeview-menu', style: 'display: none;')
      # 包含子菜单
      content_tag(:li, 
        content_tag(:a, content_tag(:i, nil, :class => item.html_options[:opts][:icon]) + ' ' +
          content_tag(:span, item.name) + content_tag(:i, nil, class: 'fa pull-right fa-angle-left'),
            {:href => '#'}.merge(item.html_options.except(:class,:id,:opts))) + sub_menu_content,
            { class: 'treeview ' + classes })
    else
      icon_classes = (item_container.level_for_item(item.key) == 1 ? item.html_options[:opts][:icon] : 'fa fa-angle-double-right' )
      badge_content = ''
      if item.html_options[:opts][:badge_text]
        badge_content = content_tag(:span, item.html_options[:opts][:badge_text],
                                    :class => "badge pull-right #{item.html_options[:opts][:badge_class]}")
      end
      content_tag(:li, 
        content_tag(:a, content_tag(:i, nil, class: icon_classes) + ' ' +
          content_tag(:span, item.name) + badge_content,
            {:href => item.url, :method => item.method}.merge(item.html_options.except(:class,:id,:opts))),
            { class: classes })
    end
  end
end
=begin
class ListBootstrap < SimpleNavigation::Renderer::Base
  def render(item_container)
    list = item_container.items.inject([]) do |list, item|
      if item.html_options[:opts]
        if item.html_options[:opts][:nav_header]
          list << li_header(item)
        elsif item.html_options[:opts][:icon]
          list << li_icon(item)
        end
      else
        list << li_tag(item)
      end
    end
    list.join.html_safe
  end
 
  private
 
  def li_tag(item)
    classes = item.selected? ? 'active' : nil
    content_tag(:li, link_to(item.name, item.url, {:method => item.method}.merge(item.html_options.except(:class,:id,:opts))), { class: classes })
  end
 
  def li_header(item)
    content_tag(:li, item.name, { class: 'nav-header' }.merge(item.html_options.except(:class,:id,:opts)))
  end
 
  def li_icon(item)
    classes = item.selected? ? 'active' : nil
    badge_content = ''
    if item.html_options[:opts][:badge_text]
      badge_content = content_tag(:span, item.html_options[:opts][:badge_text],
                                  :class => "badge pull-right #{item.html_options[:opts][:badge_class]}")
    end
    content_tag(:li, 
                content_tag(:a, content_tag(:i, nil, :class => item.html_options[:opts][:icon]) + ' ' +
                                 content_tag(:span, item.name) + badge_content,
                                 {:href => item.url, :method => item.method}.merge(item.html_options.except(:class,:id,:opts))), { class: classes })
  end
end
=end
