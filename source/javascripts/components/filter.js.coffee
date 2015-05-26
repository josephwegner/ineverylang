$(document).ready ->
  if $("[data-component='filter-input']").length && $("[data-component='filterable']").length
    $input = $("[data-component='filter-input']").first()
    $filterables = $("[data-component='filterable']")

    $input.keyup (e) ->

      # Check if the key was the "enter" key, and if there is only one result currently
      if e.which == 13 && $filterables.filter(":visible").length == 1 && $filterables.filter(":visible").data('filter-target')
        window.location.href = $filterables.filter(":visible").data 'filter-target'

      searchText = $(this).val().toLowerCase().replace(/[^A-Za-z0-9]/g, "")

      $filterables.each ->
        if $(this).data('filter-text').toLowerCase().replace(/[^A-Za-z0-9]/g, "").indexOf(searchText) >= 0
          $(this).show()
        else
          $(this).hide()

      if $filterables.filter(":visible").length == 1
        $input.css 'text-decoration', 'underline'
      else
        $input.css 'text-decoration', ''

    $input.focus()

