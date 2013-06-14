# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
lastTimeoutId = null

updateFirehose = ->
	alert "Hello"
	if $("#firehose").length > 0
		lastTimeoutId = setTimeout updateFirehose, 5000
	else
		clearTimeout lastTimeoutId
		return

$(document).on "page:change", ->
  if $("#firehose").length > 0
  	lastTimeoutId = setTimeout updateFirehose, 5000 
  else
  	clearTimeout lastTimeoutId


