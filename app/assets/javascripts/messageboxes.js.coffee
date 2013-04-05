# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

input_id = [ "#color_topline", "#color_msgbox_name", "#color_overall_background", "#color_background", "#color_foreground", "#color_link", "#color_link_hover", "#color_small_link", "#color_small_link_hover", "#color_p", "#color_super", "#color_input", "#color_input_focus", "#color_input_background", "#color_border", "#color_border_light", "#color_warning", "#color_scrollbar_thumb", "#color_scrollbar_background"]
colorArray = new Array()
colorArray[0] = ["80BC00", "888888", "FFFFFF", "F0F0F0", "FFFFFF", "80BC00", "4E8A00", "777777", "444444", "333333", "BBBBBB", "80BC00", "8AC60A", "F9F9F9", "DDDDDD", "F0F0F0", "FF3C46", "DDDDDD", "BBBBBB"]
colorArray[1] = ["CB0000", "888888", "FFFFFF", "F8F8F8", "FFFFFF", "CB0000", "820000", "855050", "444444", "333333", "BBBBBB", "CB0000", "D50A0A", "F9F9F9", "DDDDDD", "F0F0F0", "FF3C46", "DDDDDD", "BBBBBB"]
colorArray[2] = ["4D52FF", "888888", "FFFFFF", "F8F8F8", "FFFFFF", "4D52FF", "7D7FB3", "4D52FF", "363AB3", "333333", "BBBBBB", "4D52FF", "575CFF", "F9F9F9", "DDDDDD", "F0F0F0", "FF3C46", "DDDDDD", "BBBBBB"]
colorArray[3] = ["ED5B00", "888888", "FFFFFF", "F8F8F8", "FFFFFF", "ED5B00", "A13E00", "A16E00", "444444", "333333", "BBBBBB", "ED5B00", "F7650A", "F9F9F9", "DDDDDD", "F0F0F0", "FF3C46", "DDDDDD", "BBBBBB"]
colorArray[4] = ["888888", "888888", "222222", "333333", "222222", "999999", "BBBBBB", "A16E00", "444444", "CCCCCC", "BBBBBB", "3D3D3D", "777777", "333333", "343434", "666666", "FF3C46", "222222", "111111"]
colorArray[5] = ["555555", "333333", "FFFFFF", "F9F9F9", "FFFFFF", "555555", "888888", "777777", "666666", "333333", "999999", "555555", "666666", "F9F9F9", "DDDDDD", "F5F5F5", "FF3C46", "CCCCCC", "AAAAAA"]
colorArray[6] = ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
$(document).ready ->
  preview = $("#messagebox-preview")

  i = -1
  while i < input_id.length
    colorArray[6][i] = $(input_id[i]).val
    i++

  $("form[data-remote]").bind "ajax:complete", ->
    document.getElementById('iframe').contentDocument.location.reload();

  $(".color_change").click ->
    id = $(this).attr("id")
    i = -1
    while i < input_id.length
      $(input_id[i]).val colorArray[id][i]
      i++

  $iframeeditor = $("#iframe-editor")
  $iframecode = $("#iframe-code")
  $iframecode.html preview.attr "style"
  $iframeeditor.change ->
    preview.attr "style", $(this).val()
    str = $msgbxprvw.html()
    str = str.replace("/messagebox", "localhost:3000/messagebox")
    $iframecode.html str

  $("#iframe-editor").keypress (e) ->
    if e.keyCode is 13 and not e.shiftKey
      $(this).change()
      e.preventDefault()
      return

  $msgCont = $("#messages-container")
  $msgInput = $("#msginput")
  $notIce = $("#notice")
  titleize = (str) ->
    return ""  unless str?
    String(str).replace /(?:^|\s)\S/g, (c) ->
      c.toUpperCase()

  $(this).on "mouseover", ".message", ->
    $(this).children().children(".message-footer").children(".message-left").show()

  $(this).on "mouseleave", "div.message", ->
    $(this).children().children(".message-footer").children(".message-left").hide()

  $(this).on "focus", "#color_warning", ->
    $notIce.fadeIn()

  $(this).on "blur", "#color_warning", ->
    $notIce.fadeOut()