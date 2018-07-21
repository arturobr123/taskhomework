module UsuariosHelper
	def circle_img url,size=50
		div = content_tag(:div,"",class:"circle cover",
			style:"height:#{size}px; width:#{size}px; background-image:url(#{url}); background-size: cover; ")
		div.html_safe

	end
end
