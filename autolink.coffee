autoLink = (options...) ->
  url_pattern =
    /(\b(https?):\/\/[\-A-Z0-9+&@#\/%?=~_|!:,.;]*[\-A-Z0-9+&@#\/%=~_|])/ig

  if options.length > 0
    callback = options[0].callback if options[0].callback and Object.prototype.toString.call(options[0].callback) is '[object Function]'
    delete options[0].callback

    omission = options[0].omission || '...'
    delete options[0].omission

    limit = options[0].limit
    delete options[0].limit

    link_attributes = ''

    for key, value of options[0]
      link_attributes += " #{key}='#{value}'"

    @replace url_pattern, (match, url) ->
      return callback(url) if callback and callback(url)
      displayUrl = url
      if limit
        displayUrl = displayUrl.replace /https?:\/{2}/, ''
        if displayUrl.length > limit
          displayUrl = "#{displayUrl.substr(0, limit - omission.length)}#{omission}"

      "<a href='#{url}'#{link_attributes}>#{displayUrl}</a>"

  else
    @replace url_pattern, "<a href='$1'>$1</a>"

String.prototype['autoLink'] = autoLink
