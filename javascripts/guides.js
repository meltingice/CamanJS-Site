(function() {
  var setActiveSection;

  setActiveSection = function($spy) {
    var $nav, fx, id;
    id = $spy.attr('id');
    $spy.attr('id', '');
    fx = $("<div>").css({
      position: 'absolute',
      visibility: 'hidden',
      top: $(document).scrollTop() + 'px'
    }).attr('id', id).appendTo(document.body);
    document.location.hash = '#' + id;
    fx.remove();
    $spy.attr('id', id);
    $nav = $("#GuideSections li > a").filter("[href=#" + ($spy.attr('id')) + "]");
    $nav.parents('ul').find('.Active').removeClass('Active');
    return $nav.parents('li').addClass('Active');
  };

  $(document).ready(function() {
    var $spies;
    $("#GuideSections").on('click', 'a', function() {
      var $target, top;
      $target = $($(this).attr('href'));
      top = Math.max(0, $target.position().top - 129);
      document.location.hash = $(this).attr('href');
      setTimeout(function() {
        return $('body').scrollTop(top);
      }, 50);
      return false;
    });
    $spies = _.map($("#GuideSections li > a"), function(a) {
      return $($(a).attr('href'));
    });
    $spies = $spies.reverse();
    return $(document).on('scroll', _.throttle(function() {
      var $spy, top, _i, _len;
      top = $(document).scrollTop();
      for (_i = 0, _len = $spies.length; _i < _len; _i++) {
        $spy = $spies[_i];
        if (top >= $spy.position().top - 130) {
          setActiveSection($spy);
          return;
        }
      }
    }, 200));
  });

}).call(this);
