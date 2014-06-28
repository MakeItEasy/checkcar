module FrontHelper
  def current_nav_class(path)
    current_path = request.original_fullpath
    if path == '/'
      current_path == path ? 'active' : ''
    else
      current_path.start_with?(path) ? 'active' : ''
    end
  end
end

