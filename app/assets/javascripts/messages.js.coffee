# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $("#myTab a:first").tab "show"
  $("form").submit ->
    valuesToSubmit = $(this).serialize()
    alert valuesToSubmit
    $.ajax
      type: GET
      url: "/messages/loadmore"
      cache: false
      data: valuesToSubmit
      dataType: "JSON"
      success: (html) ->
        $("#yours").append html

    false

  $("#yours").delegate ".pagination ul li", "click", ->
    $(".pagination").remove()
    url = $(this).children().attr("href")
    page = url.split("?")
    page = page[page.length - 1]
    urlPath = "/messages/loadmore?" + page
    fakeUrl = "/messages?" + page
    $("#yours").load urlPath
    window.history.pushState "sdasdf", "safaegr", fakeUrl
    false

  $(".tab-header").click ->
    $("#yours").load 'messages/loadmore'
    window.history.pushState '', '', '/messages'