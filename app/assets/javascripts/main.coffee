# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "turbolinks:load page:fetch", ()->

	$(".button-collapse").sideNav()
	console.log("main.coffee")

	$("#notificationButton").on "click", (ev)-> #boton de notificaciones

		selector = $(this).attr("for")     #para obtener el id de modal notifications
		$(selector).click()                #y darle click para abrirlo y mostrar las notificaciones

		if $("#notifications").hasClass("active")
			ev.preventDefault()
		else
			$(".preloader_notifications").addClass("active")
			$(".preloaderDivNotifications").css("display": "inline")


		$("#notifications").toggleClass("active")
		console.log("notification main.coffee")

		return $("#notifications").hasClass("active")


	$('textarea').autosize()         #para que el text area de haga grande en automatico
	Materialize.updateTextFields()
	$('select').material_select()


	#esto era para volver a cargar la pagina, por el error de los selects
	#if $(".select-wrapper > .select-wrapper").length > 0
	#	location.reload()


	$('.datepicker.disponible').pickadate(selectMonths: true, selectYears: true ,min: [2017,1,1],
  max: [2020,12,12] )

	$('.datepicker.birthday').pickadate(selectMonths: true, selectYears: 54)

	$('.modal-trigger').leanModal()

	$('.dropdown-button').dropdown()

	$('.tabs').tabs()

	#aviso de privasidad cuando entras al perfil del usuario
	if document.getElementById("modalAvisoPrivasidad")
		$("#modalAvisoPrivasidad").openModal()


	$('.tooltipped').tooltip({delay: 50})

	$('.collapsible').collapsible()

	$('.collapsible').collapsible({accordion : true })

	$('.parallax').parallax()

	$('.materialboxed').materialbox()
