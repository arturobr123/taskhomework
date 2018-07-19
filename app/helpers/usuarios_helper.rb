module UsuariosHelper
	def circle_img url,size=50
		div = content_tag(:div,"",class:"circle cover popImage",
			style:"height:#{size}px; width:#{size}px; background-image:url(#{url}); background-size: cover; float: left;
")
		div.html_safe
		
	end
end
