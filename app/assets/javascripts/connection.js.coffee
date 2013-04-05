# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("*[data-remote]").on "ajax:success", ->
    iD = $(this).attr("id")
    $("#allow,#ban").toggle()  if iD is "ban" or iD is "allow"
    $("#unbanip,#banip").toggle()  if iD is "banip" or iD is "unbanip"
    return
#  removeDuplicateID = ->
#  $("[id]").each ->
#    ids = $("[id=" + @id + "]")
#    $(ids[1]).remove()  if ids.length > 1 and ids[0] is this
#
#  $(".container").on "click", "#next_page", ->
#    url = $(this).attr("href")
#    $.get url, (data) ->
#      $("#next_page").remove()
#      $("#poster_messages").append data
#      removeDuplicateID();