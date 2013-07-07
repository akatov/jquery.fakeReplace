(($) ->
  $.fn.fakeReplace = (options) ->
    settings = $.extend(
      element: null
      text: ""
      css: []
    , options)
    @each ->
      self = $ @
      r = $('<span>' + settings.text + '</span>')
      r.appendTo('body')
      o = self.offset()
      w = r.width()
      self.offset top: -1000, left: 0
      while self.width() > w
        f = self.css('font-size')
        f = f.substr(0, f.length - 2)
        --f
        self.css 'font-size', "#{f}px"
      while self.width() < w
        self.html "#{self.html()}&nbsp;"
      r.css('position', 'absolute').offset(o).show()
  null
)(jQuery)
