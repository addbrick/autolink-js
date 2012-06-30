describe "autolink", ->
  it "can be called on a string", ->
    expect("hi there".autoLink()).toBeDefined()

  it "does not alter a string with no URL present", ->
    expect("hi again".autoLink()).toEqual("hi again")

  it "returns the string with the URLs hyperlinked", ->
    expect("Check out this search engine http://google.com".autoLink()).
    toEqual(
      "Check out this search engine <a href='http://google.com'>" +
      "http://google.com</a>"
    )

  it "does not hyperlink additional non-URL text", ->
    expect("LMSTFY: http://google.com and RTFM".autoLink()).
    toEqual(
      "LMSTFY: <a href='http://google.com'>http://google.com</a> and RTFM"
    )

  it "correctly hyperlinks text with multiple URLs", ->
    expect(
      "Google is http://google.com and Twitter is http://twitter.com".autoLink()
    ).toEqual(
      "Google is <a href='http://google.com'>http://google.com</a> and " +
      "Twitter is <a href='http://twitter.com'>http://twitter.com</a>"
    )

  it "correctly hyperlinks URLs, regardless of TLD", ->
    expect("Click here http://bit.ly/1337 now".autoLink()).
    toEqual(
      "Click here <a href='http://bit.ly/1337'>http://bit.ly/1337</a> now"
    )

  it "correctly hyperlinks URLs, regardless of subdomain", ->
    expect("Check it: http://some.sub.domain".autoLink()).
    toEqual(
      "Check it: <a href='http://some.sub.domain'>http://some.sub.domain</a>"
    )

  it "correctly handles punctuation", ->
    expect("Go here now http://google.com!".autoLink()).
    toEqual(
      "Go here now <a href='http://google.com'>http://google.com</a>!"
    )

  it "sets link attributes based on the options provided", ->
    expect("Google it: http://google.com".autoLink(target: "_blank")).
    toEqual(
      "Google it: <a href='http://google.com' target='_blank'>" +
      "http://google.com</a>"
    )

  it "sets multiple link attributes if more than one is given", ->
    expect(
      "Google it: http://google.com".autoLink(target: "_blank", rel: "nofollow")
    ).toEqual(
      "Google it: <a href='http://google.com' target='_blank' " +
      "rel='nofollow'>http://google.com</a>"
    )

  describe "limit option", ->
    it "removes http", ->
      expect("Google it: http://google.com".autoLink(limit: 30))
      .toEqual(
        "Google it: <a href='http://google.com'>" +
        "google.com</a>"
      )

    it "truncates link if link is longer than limit - omission", ->
      expect(
        "Google it: http://google.com/derp/derp/derpderp/derp".autoLink(limit: 30)
      ).toEqual(
        "Google it: <a href='http://google.com/derp/derp/derpderp/derp'>" +
        "google.com/derp/derp/derpde...</a>"
      )

    it "does not truncate link if link shorter than limit", ->
      expect(
        "Google it: http://google.com".autoLink(limit: 30)
      ).toEqual(
        "Google it: <a href='http://google.com'>" +
        "google.com</a>"
      )

    it "does not truncate link if link is limit", ->
      expect("Google it: http://google.com/derp/derpderp/derpd".autoLink(limit: 30))
      .toEqual(
        "Google it: <a href='http://google.com/derp/derpderp/derpd'>" +
        "google.com/derp/derpderp/derpd</a>"
      )


  describe "omission option", ->
    it "truncates link if link is longer than limit - omission and appends omission end", ->
      expect(
        "Google it: http://google.com/derp/derp/derpderp/derp".autoLink(
          limit: 30
          omission: '***'
        )
      ).toEqual(
        "Google it: <a href='http://google.com/derp/derp/derpderp/derp'>" +
        "google.com/derp/derp/derpde***</a>"
      )
