#cuando das click a este boton ,se activa la animacion de cargar
$(document).on "click", ".uploadFile", (ev)->
  if $('.type_homework').val() == "2"
    $('#modalToPlagiarism').openModal()
    $(".preloader-wrapper").addClass("active")
    $('.preloaderDiv').css('display', 'block')
