(function() {
  var busy, caman, changed, filters, presetBusy, presetCaman, render, renderPreset,
    __hasProp = {}.hasOwnProperty;

  caman = null;

  presetCaman = null;

  filters = {};

  busy = false;

  changed = false;

  render = _.throttle(function() {
    if (busy) {
      changed = true;
      return;
    } else {
      changed = false;
    }
    busy = true;
    return caman.revert(function() {
      var filter, value;
      for (filter in filters) {
        if (!__hasProp.call(filters, filter)) continue;
        value = filters[filter];
        value = parseFloat(value, 10);
        if (value === 0) {
          continue;
        }
        caman[filter](value);
      }
      return caman.render(function() {
        busy = false;
        if (changed) {
          return render();
        }
      });
    });
  }, 500);

  presetBusy = false;

  renderPreset = function(preset) {
    var $filter, name;
    if (presetBusy) {
      return;
    }
    $("#PresetFilters a").removeClass('Active');
    $filter = $("#PresetFilters a[data-preset='" + preset + "']");
    name = $filter.html();
    $filter.addClass('Active').html('Rendering...');
    presetBusy = true;
    return presetCaman.revert(function() {
      presetCaman[preset]();
      return presetCaman.render(function() {
        $filter.html(name);
        return presetBusy = false;
      });
    });
  };

  $(document).ready(function() {
    caman = Caman('#example');
    presetCaman = Caman('#preset-example');
    $('.FilterSetting input').each(function() {
      var filter;
      filter = $(this).data('filter');
      return filters[filter] = $(this).val();
    });
    $('#Filters').on('change', '.FilterSetting input', function() {
      var filter, value;
      filter = $(this).data('filter');
      value = $(this).val();
      filters[filter] = value;
      $(this).find('~ .FilterValue').html(value);
      return render();
    });
    return $('#PresetFilters').on('click', 'a', function() {
      return renderPreset($(this).data('preset'));
    });
  });

}).call(this);
