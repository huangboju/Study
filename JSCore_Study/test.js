'use strict';

var factorial = function (n) {
  if (n < 0)
    return;
  if (n === 0)
    return 1;
  return n * factorial(n - 1)
};

var colorForWord = function(word) {
    if (!colorMap[word])
        return;
    /// makeNSColor swift中传递过来的
    return makeNSColor(colorMap[word])
};

var colorMap = {
    "red": {"red": 255, "green": 0, "blue": 0},
    "orange": {"red": 255, "green": 153, "blue": 0},
    "yellow": {"red": 153, "green": 153, "blue": 0},
    "green": {"red": 0, "green": 255, "blue": 0},
    "blue": {"red": 0, "green": 0, "blue": 255},
    "purple": {"red": 153, "green": 0, "blue": 153},
    "brown": {"red": 102, "green": 51, "blue": 0},
    "gray": {"red": 153, "green": 153, "blue": 153},
    "cyan": {"red": 0, "green": 255, "blue": 255},
};


var jsExport = function(item) {
    /// word swift中传递过来的
    return Item.itemWithTitleText('我是JS，传递给我的参数是:' + item.title, item.text)
};
