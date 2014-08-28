Rails.application.config.assets.precompile += %w( front.css front.js front_user.css)
Rails.application.config.assets.precompile += %w( back.css back.js)
Rails.application.config.assets.precompile += %w( devise_admin.css)
Rails.application.config.assets.precompile += %w( devise_user.css devise_user.js)
Rails.application.config.assets.precompile += %w( html5shiv.js respond.js css3-mediaqueries.js)
=begin
Rails.application.config.assets.precompile += %w( ckeditor/filebrowser/javascripts/*.js )
Rails.application.config.assets.precompile += %w( ckeditor/filebrowser/stylesheets/*.css )
Rails.application.config.assets.precompile += %w( ckeditor/*.md )
Rails.application.config.assets.precompile += %w( ckeditor/lang/*.js )
=end
Rails.application.config.assets.precompile += %w( fonts/*.*)
Rails.application.config.assets.precompile += %w( icons/grid/*.*)

# bsie
Rails.application.config.assets.precompile += %w( bsie/bootstrap-ie6.css bsie/ie.css bsie/bootstrap-ie.js)

# 百度地图
Rails.application.config.assets.precompile += %w( baidu_map/SearchInfoWindow.js)
