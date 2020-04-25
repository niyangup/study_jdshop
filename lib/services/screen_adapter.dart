import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static init(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
  }

  static height(double height) {
    return ScreenUtil().setHeight(height);
  }

  static width(double width) {
    return ScreenUtil().setWidth(width);
  }

  ///获取设备高度
  static getScreenHeight() {
    return ScreenUtil.screenHeightDp;
  }

  ///获取设备宽度
  static getScreenWidth() {
    return ScreenUtil.screenWidthDp;
  }

  ///适配字体
  static size(double value) {
    return ScreenUtil().setSp(value);
  }
}
