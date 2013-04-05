# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  Reloder = ->
    window.opener.popUpClosed()  if window.opener and not window.opener.closed
  openSignUp = ->
    window.close()
    window.open "/users/sign_up", "_blank"
  $("input#user_info_avatar").change ->
    $("#avatar_preview").fadeOut 1000
    image = new Image()
    image.src = $(this).val()
    $("#avatar_preview img").attr "src", image.src
    $("#avatar_preview img").load ->
      $("#avatar_preview").fadeIn 1000

  $("form").submit ->
    Reloder()
    window.close()

  $("#sign-up").click ->
    window.open "/users/sign_up", "_blank"
    Reloder()
    window.close()