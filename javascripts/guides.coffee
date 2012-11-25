---
# Required
---

setActiveSection = ($spy) ->
  $nav = $("#GuideSections li > a").filter("[href=##{$spy.attr('id')}]")
  $nav.parents('ul').find('.Active').removeClass('Active')
  $nav.parents('li').addClass('Active')

$(document).ready ->
  $("#GuideSections").on 'click', 'a', ->
    $target = $ $(@).attr('href')
    top = Math.max 0, $target.position().top - 129

    document.location.hash = $(@).attr('href')
    
    setTimeout ->
      $('body').scrollTop top
    , 50

    return false

  $spies = _.map $("#GuideSections li > a"), (a) -> $ $(a).attr('href')
  $spies = $spies.reverse()
  $(document).on 'scroll', _.throttle ->
    top = $(document).scrollTop()
    for $spy in $spies
      if top >= $spy.position().top - 130
        setActiveSection $spy
        return

    # We're above the first element, so choose it by default
    setActiveSection $spies[$spies.length - 1]
  , 200