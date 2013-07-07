(function($) {
  $.fn.fakeReplace = function(options) {
    var settings;
    settings = $.extend({
      element: null,
      text: "",
      css: []
    }, options);
    return this.each(function() {
      var f, o, r, self, w;
      self = $(this);
      r = $('<span>' + settings.text + '</span>');
      r.appendTo('body');
      o = self.offset();
      w = r.width();
      self.offset({
        top: -1000,
        left: 0
      });
      while (self.width() > w) {
        f = self.css('font-size');
        f = f.substr(0, f.length - 2);
        --f;
        self.css('font-size', "" + f + "px");
      }
      while (self.width() < w) {
        self.html("" + (self.html()) + "&nbsp;");
      }
      return r.css('position', 'absolute').offset(o).show();
    });
  };
  return null;
})(jQuery);
