$ ->
  $('.btn').each (i, el) ->
    $el = $(el)
    $el.attr('data-style', 'zoom-out')
    $el.addClass('ladda-button')
    $el.html("<span class='ladda-label'>#{$el.html()}</span>")
    if $el.hasClass('btn-default')
      # white button - use black spinner
      $el.attr('data-spinner-color', '#000000')

  Ladda.bind('.btn')
