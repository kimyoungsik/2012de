# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#network_participation_network_name').autocomplete
    source: $('#network_participation_network_name').data('autocomplete-source')