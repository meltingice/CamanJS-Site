---
# this is required
---

caman = null
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
  caman.revert ->
    for own filter, value of filters
      value = parseFloat value, 10
      continue if value is 0

      caman[filter](value)

    caman.render ->
      busy = false
      render() if changed
, 500

$(document).ready ->
  caman = Caman '#example'

  $('.FilterSetting input').each ->
    filter = $(@).data 'filter'
    filters[filter] = $(@).val()

  $('#Filters').on 'change', '.FilterSetting input', ->
    filter = $(@).data 'filter'
    value = $(@).val()
    
    filters[filter] = value

    $(@).find('~ .FilterValue').html value
    render()