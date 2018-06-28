#COMENTARIOS


#cuando das click a este boton ,se activa la animacion de cargar
$(document).on "click", ".buttonBuscador", (ev)->
	console.log("HOLA MUNDO");
	$(".preloader-wrapper").addClass("active")
	$(".preloaderDiv").css("display": "inline-block")
