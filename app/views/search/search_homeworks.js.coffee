$("#data").html("<%=j render @homeworks %>")
$("#how_many_homeworks").html("<%= @how_many_homeworks %>")

$(".preloader-wrapper").removeClass("active")
$(".preloaderDiv").css("display": "none")
