(function($) {
  $.fn.fakeReplace = function(replaceFn) {
    return this.each(function() {
      var $t, f, o, orig, r, ret, w;
      $t = $(this);
      orig = $t.html();
      ret = replaceFn(orig);
      if (ret === orig) {
        return;
      }
      r = $t.clone().html(ret).appendTo('body');
      o = $t.offset();
      w = r.width();
      $t.offset({
        top: -1000,
        left: 0
      });
      while ($t.width() > w) {
        f = $t.css('font-size');
        f = f.substr(0, f.length - 2);
        --f;
        $t.css('font-size', "" + f + "px");
      }
      while ($t.width() < w) {
        $t.html("" + ($t.html()) + "&nbsp;");
      }
      return r.css('position', 'absolute').offset(o).show();
    });
  };
  return null;
})(jQuery);
