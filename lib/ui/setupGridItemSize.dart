import 'package:flutter/material.dart';

class GridItemSize {
  var ctx;
  var aspectRatio;
  var cellHeight;
  GridItemSize(this.ctx,this.cellHeight) {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(ctx).size.width;
    var _crossAxisCount = 2;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    
    aspectRatio = _width / cellHeight;
  }
}
