setActiveSection = ($spy) ->
  id = $spy.attr('id')
  $spy.attr('id', '')
  fx = $("<div>")
    .css(
      position: 'absolute'
      visibility: 'hidden'
      top: $(document).scrollTop() + 'px'
    )
    .attr('id', id)
    .appendTo(document.body)

  document.location.hash = '#' + id

  fx.remove()
  $spy.attr 'id', id

  $nav = $("#GuideSections li > a").filter("[href=##{$spy.attr('id')}]")
  $nav.parents('ul').find('.Active').removeClass('Active')
  $nav.parents('li').addClass('Active')

$(document).ready ->
  # Fixes the fixed header offset when clicking guide links
  $("#GuideSections").on 'click', 'a', ->
    $target = $ $(@).attr('href')
    top = Math.max 0, $target.position().top - 129

    document.location.hash = $(@).attr('href')
    
    setTimeout ->
      $('body').scrollTop top
    , 50

    return false

  # Scrollspy
  $spies = _.map $("#GuideSections li > a"), (a) -> $ $(a).attr('href')
  $spies = $spies.reverse()
  $(document).on 'scroll', _.throttle ->
    top = $(document).scrollTop()
    for $spy in $spies
      if top >= $spy.position().top - 130
        setActiveSection $spy
        return
  , 200