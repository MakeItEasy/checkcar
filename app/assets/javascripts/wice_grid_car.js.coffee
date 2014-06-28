$(document).on 'page:load ready', -> initWiceGridCar()

initWiceGridCar = ->

  $(".wice-grid-container").each (index, wiceGridContainer) ->
    setupBulkToggleForActionColumn_car wiceGridContainer

setupBulkToggleForActionColumn_car = (wiceGridContainer) ->
  $('.select-all', wiceGridContainer).click ->
    $('.sel .icheckbox_minimal', wiceGridContainer).attr('aria-checked', true)
    $('.sel .icheckbox_minimal', wiceGridContainer).addClass('checked')

  $('.deselect-all', wiceGridContainer).click ->
    $('.sel .icheckbox_minimal', wiceGridContainer).attr('aria-checked', false)
    $('.sel .icheckbox_minimal', wiceGridContainer).removeClass('checked')
