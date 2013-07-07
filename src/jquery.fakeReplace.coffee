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
  #   and returns the fake contents to replace it with. replaceFn should return
  #   null if the tag should be left alone
  $.fn.fakeReplace = (replaceFn) ->
    @each ->
      $t = $ @
      orig = $t.html()
      ret = replaceFn orig
      return if ret == orig
      r = $t.clone().html(ret).appendTo('body').css($t.getStyleObject())
      o = $t.offset()
      w = r.width()
      $t.offset top: -1000, left: 0
      while $t.width() > w
        f = $t.css('font-size')
        f = f.substr(0, f.length - 2)
        --f
        $t.css 'font-size', "#{f}px"
      while $t.width() < w
        $t.html "#{$t.html()}&nbsp;"
      r.css('position', 'absolute').offset(o).show()
  null
)(jQuery)
