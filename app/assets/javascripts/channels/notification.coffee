#CANAL DESDE LA PARTE DEL CLIENTE PARA LAS NOTIFICACIONES DEL USUARIO
App.notification = App.cable.subscriptions.create "NotificationChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log("received notification.coffee")
    Materialize.toast('Has recibido una nueva notificación!', 3000)
    if data.action == "new_notification"
    	$("#notification").html(data.message)
