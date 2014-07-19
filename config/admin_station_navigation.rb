# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items.
  # Defaults to 'selected' navigation.selected_class = 'your_selected_class'
  navigation.selected_class = 'active'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  # navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that
  # will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name, item| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false
  
  # If this option is set to true, all item names will be considered as safe (passed through html_safe). Defaults to false.
  # navigation.consider_item_names_as_safe = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>if: -> { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>unless: -> { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>.
    #           :opts - 参照class ListBootstrap, :icon, :badge_text, :badge_class
    #                   (针对子菜单)如果需要用badge，那么opts中必需有icon
    #
    primary.item :dashboard, I18n.t('view.controller.dashboard'), back_mystation_root_path,
      :opts => {:icon => 'fa fa-dashboard'}
    primary.item :order_phones, I18n.t('view.menu.new_order_phone'), new_back_mystation_order_phone_path,
      :opts => {icon: 'ion ion-android-call' }, if: ->{ can? :create, OrderPhone }
    primary.item :orders, Order.model_name.human, back_mystation_orders_path(scope: 'today'),
      :opts => {icon: 'ion ion-bag' }, if: ->{ can? :read, Order}
    primary.item :station_admins, StationAdmin.model_name.human, back_mystation_station_admins_path,
      :opts => {icon: 'ion ion-person-stalker' }, if: ->{ can? :read, StationAdmin }
    primary.item :settings, I18n.t('view.menu.settings'), nil, :opts => {icon: 'ion ion-settings' },
      if: ->{can? :show, :settings} do |sub_nav|
      sub_nav.item :show, I18n.t('view.menu.station_base_info'), back_mystation_station_path, if: -> {can? :show, Station}
    end
    primary.item :personal, I18n.t('view.controller.personal'), nil, :opts => {icon: 'fa fa-th' } do |sub_nav|
      sub_nav.item :show, I18n.t('view.action.personal.show'), back_personal_show_path
      sub_nav.item :password, I18n.t('view.action.personal.password'), back_personal_password_path
    end

    # you can also specify html attributes to attach to this particular level
    # works for all levels of the menu
    # primary.dom_attributes = {id: 'menu-id', class: 'menu-class'}

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false
  end
end