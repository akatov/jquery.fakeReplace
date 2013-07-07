(($) ->
  # @param [Function] replaceFn a function which takes the contents of the tag
  #   and returns the fake contents to replace it with. replaceFn should return
  #   null if the tag should be left alone
  $.fn.fakeReplace = (replaceFn) ->
    @each ->
      $t = $ @
      orig = $t.html()
      ret = replaceFn orig
      return if ret == orig
      r = $t.clone().html(ret).appendTo('body')
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
