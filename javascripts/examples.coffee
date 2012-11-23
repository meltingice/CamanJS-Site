---
# this is required
---

caman = null
filters = {}
busy = false

# Triggers the render, but only every 1.5 seconds
render = _.throttle ->
  return if busy

  busy = true
  caman.revert ->
    for own filter, value of filters
      value = parseInt value, 10
      continue if value is 0

      console.log filter, value
      caman[filter](value)

    caman.render -> busy = false
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

    render()