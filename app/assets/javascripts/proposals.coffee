$(document).on "click", ".selectProposal", (ev)->
  $('#modalToSelectProposal').openModal()
  $(".preloader-wrapper").addClass("active")
  $('.preloaderDiv').css('display', 'block')
