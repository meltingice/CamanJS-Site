caman = null
presetCaman = null
filters = {} # Filter values

busy = false # Are we currently rendering?
changed = false # Tracks unrendered changes

# Triggers the render, throttled to every 500ms max
render = _.throttle ->
  if busy
    changed = true
    return
  else
    changed = false

  busy = true
  caman.revert(false)
  for own filter, value of filters
    value = parseFloat value, 10
    continue if value is 0

    caman[filter](value)

  caman.render ->
    busy = false
    render() if changed
, 300

presetBusy = false
renderPreset = (preset) ->
  return if presetBusy
  
  $("#PresetFilters a").removeClass('Active')
  
  $filter = $("#PresetFilters a[data-preset='#{preset}']")
  name = $filter.html()
  $filter
    .addClass('Active')
    .html('Rendering...')
  
  presetBusy = true
  presetCaman.revert(false)
  presetCaman[preset]()
  presetCaman.render ->
    $filter.html(name)

    presetBusy = false

$(document).ready ->
  return unless $("#example").length > 0
  
  caman = Caman '#example'
  presetCaman = Caman '#preset-example'

  $('.FilterSetting input').each ->
    filter = $(@).data 'filter'
    filters[filter] = $(@).val()

  $('#Filters').on 'change', '.FilterSetting input', ->
    filter = $(@).data 'filter'
    value = $(@).val()
    
    filters[filter] = value

    $(@).find('~ .FilterValue').html value
    render()

  $('#PresetFilters').on 'click', 'a', ->
    renderPreset $(@).data('preset')

