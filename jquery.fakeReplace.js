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
  $.fn.fakeReplace = function(replaceFn, root) {
    return this.each(function() {
      var $r, $s, $t, o, orig, ret, w;
      $t = $(this);
      orig = $t.html();
      ret = replaceFn(orig);
      if (ret === orig) {
        return;
      }
      root || (root = $t.offsetParent());
      $r = $t.clone().html(ret).appendTo(root).css($t.getStyleObject());
      o = $t.offset();
      w = $r.width();
      $s = $t.clone().css('position', 'absolute');
      $t.css('position', 'relative').offset({
        top: -100000,
        left: -100000
      });
      $t.html('');
      while ($t.width() < w) {
        $t.html("" + ($t.html()) + "&nbsp;");
      }
      $t.append($s);
      return $r.css('position', 'relative').offset(o).show();
    });
  };
  return null;
})(jQuery);
