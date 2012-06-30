autoLink = (options...) ->
  url_pattern =
    /(\b(https?):\/\/[\-A-Z0-9+&@#\/%?=~_|!:,.;]*[\-A-Z0-9+&@#\/%=~_|])/ig

  if options.length > 0
    if options[0].limit
      limit = options[0].limit
      delete options[0].limit

    link_attributes = ''

    for key, value of options[0]
      link_attributes += " #{key}='#{value}'"

    @replace url_pattern, (match, url) ->
      displayUrl = url
      if limit
        displayUrl = displayUrl.replace /https?:\/{2}/, ''
        if displayUrl.length > limit
          displayUrl = "#{displayUrl.substr(0, limit)}..."

      "<a href='#{url}'#{link_attributes}>#{displayUrl}</a>"

  else
    @replace url_pattern, "<a href='$1'>$1</a>"

String.prototype['autoLink'] = autoLink
