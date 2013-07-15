(($) ->
  $.fn.getStyleObject = ->
    dom = @get 0
    returns = {}
    if window.getComputedStyle
      camelize = (a,b) -> b.toUpperCase()
      style = window.getComputedStyle(dom, null)
      for prop in style
        camel = prop.replace(/\-([a-z])/g, camelize)
        val = style.getPropertyValue(prop)
        returns[camel] = val
      return returns
    if dom.currentStyle
      style = dom.currentStyle;
      for prop in style
        returns[prop] = style[prop]
      return returns
    @css()

  # @param [Function] replaceFn a function which takes the contents of the tag
  #  and returns the fake contents to replace it with. replaceFn should be the
  #  identity if the tag should be left alone
  # @param [String, jQuery] root where to attach the replacement to. Defaults to
  #  the offsetParent() of this
  $.fn.fakeReplace = (replaceFn, root) ->
    @each ->
      $t = $ @
      orig = $t.html()
      ret = replaceFn(orig)
      return if ret == orig
      root ||= $t.offsetParent()
      $r = $t.clone().html(ret).appendTo(root).css($t.getStyleObject())
      o = $t.offset()
      w = $r.width()
      $s = $t.clone().css('position', 'absolute')
      $t.css('position', 'relative').offset(top: -100000, left: -100000)
      # fill $t with spaces to be as wide as w
      $t.html('')
      $t.css('margin-right', w)
      # and attach a new tag with the original contents of $t in it but outside the flow
      $t.append($s)
      $r.css('position', 'relative').offset(o).show()
  null
)(jQuery)
