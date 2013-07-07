(function($) {
  $.fn.getStyleObject = function() {
    var camel, camelize, dom, prop, returns, style, val, _i, _j, _len, _len1;
    dom = this.get(0);
    returns = {};
    if (window.getComputedStyle) {
      camelize = function(a, b) {
        return b.toUpperCase();
      };
      style = window.getComputedStyle(dom, null);
      for (_i = 0, _len = style.length; _i < _len; _i++) {
        prop = style[_i];
        camel = prop.replace(/\-([a-z])/g, camelize);
        val = style.getPropertyValue(prop);
        returns[camel] = val;
      }
      return returns;
    }
    if (dom.currentStyle) {
      style = dom.currentStyle;
      for (_j = 0, _len1 = style.length; _j < _len1; _j++) {
        prop = style[_j];
        returns[prop] = style[prop];
      }
      return returns;
    }
    return this.css();
  };
  $.fn.fakeReplace = function(replaceFn) {
    return this.each(function() {
      var $t, f, o, orig, r, ret, w;
      $t = $(this);
      orig = $t.html();
      ret = replaceFn(orig);
      if (ret === orig) {
        return;
      }
      r = $t.clone().html(ret).appendTo('body').css($t.getStyleObject());
      o = $t.offset();
      w = r.width();
      $t.css('position', 'relative').offset({
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
