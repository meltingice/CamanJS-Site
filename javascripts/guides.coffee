---
# Required
---

$(document).ready ->
  $("#GuideSections").on 'click', 'a', ->
    $target = $ $(@).attr('href')
    top = Math.max 0, $target.position().top - 129

    $('body').scrollTop top
    #$(@).parents('ul').find('.Active').removeClass('Active')
    #$(@).parents('li').addClass('Active')

    return false

  $spies = _.map $("#GuideSections li > a"), (a) -> $ $(a).attr('href')
  $spies = $spies.reverse()
  $(document).on 'scroll', _.throttle ->
    top = $(document).scrollTop()
    for $spy in $spies
      if top >= $spy.position().top - 130
        $nav = $("#GuideSections li > a").filter("[href=##{$spy.attr('id')}]")
        $nav.parents('ul').find('.Active').removeClass('Active')
        $nav.parents('li').addClass('Active')

        return
  , 200