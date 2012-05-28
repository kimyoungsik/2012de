module KitsHelper
  
  def redirect_back_or(default)
     redirect_to(session[:return_to] || default)
     clear_return_to
  end

  def clear_return_to
      session[:return_to] = nil
  end
end
