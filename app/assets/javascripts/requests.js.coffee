# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
lastTimeoutId = null

updateHistories = ->
	request_id = $("#histories").attr("data-id")

	if($('.update').length > 0)
		after = $('.update:first-child').attr("data-id")
	else
		after = 0
	$.getScript('/request_histories.js?request_id=' + request_id  + '&after=' + after)
	$.getScript('/requests/' + request_id + '.js')
	#console.log("Calling request:" + request_id + " time: " + after)

	if $("#histories").length > 0
		lastTimeoutId = setTimeout updateHistories, 5000
	else
		clearTimeout lastTimeoutId
		return

$(document).ready ->
  if $("#histories").length > 0
  	lastTimeoutId = setTimeout updateHistories, 5000 
  else
  	clearTimeout lastTimeoutId
