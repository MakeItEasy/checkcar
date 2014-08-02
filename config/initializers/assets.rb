Rails.application.config.assets.precompile += %w( front.css front.js)
Rails.application.config.assets.precompile += %w( back.css back.js)
Rails.application.config.assets.precompile += %w( devise_admin.css)
Rails.application.config.assets.precompile += %w( devise_user.css devise_user.js)
=begin
Rails.application.config.assets.precompile += %w( ckeditor/filebrowser/javascripts/*.js )
Rails.application.config.assets.precompile += %w( ckeditor/filebrowser/stylesheets/*.css )
Rails.application.config.assets.precompile += %w( ckeditor/*.md )
Rails.application.config.assets.precompile += %w( ckeditor/lang/*.js )
=end
Rails.application.config.assets.precompile += %w( fonts/*.*)
Rails.application.config.assets.precompile += %w( icons/grid/*.*)

# 百度地图
Rails.application.config.assets.precompile += %w( baidu_map/SearchInfoWindow.js)
