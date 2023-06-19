/*封装项目中大多数情况下的按钮使用*/
/*没有对外暴露child,不让去重写child控件,防止自定义TextStyle*/
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget htButton({
  Widget? child, //自定义child
  String? title, //title为按钮文字
  double? width, //自定义宽度
  double? height, //自定义高度
  double? fontSize, //自定义文字大小
  FontWeight? fontWeight, //自定义文字字体
  Color? backgroundColor, //自定义背景颜色
  Color? disabledColor, //自定义不可点击时背景颜色
  Color? foregroundColor, //自定义文字颜色
  VoidCallback? onPressed, //自定义点击回调
  double elevation = 0, //自定义阴影,系统默认是2
  bool enable = true, //是否禁用按钮,附自动切换背景色
  double borderWidth = 0, //自定义边框大小
  Color borderColor = Colors.transparent, //自定义边框颜色
  // double? radius, //自定义圆角大小,如果不设置,默认自带的圆角效果
}) {
  /*包一层的好处是不允许外界直接调用Button的各种属性*/
  return ElevatedButton(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: fontSize ?? 14.sp, //功能按钮类UI图默认都是14
          fontWeight: fontWeight ?? FontWeight.w500, //功能按钮类UI都是Medium
        ),
      ),
      fixedSize: MaterialStateProperty.all(
        Size(
          width ?? 0, //自定义宽度
          height ?? 44.w, //自定义高度
        ),
      ),
      backgroundColor: enable == true //不在textStyle中设置,便于buttonTheme统一修改
          ? MaterialStateProperty.all(
              backgroundColor ?? Colors.blue, //主题蓝色
            )
          : MaterialStateProperty.all(
              disabledColor ?? Colors.grey, //主题红色不可点击状态
            ),
      // overlayColor: MaterialStateProperty.all(
      //   backgroundColor ?? Colors.grey, //主题红色不可点击状态
      // ),
      foregroundColor: MaterialStateProperty.all(
        foregroundColor ?? Colors.white, //不在textStyle中设置,便于buttonTheme统一修改
      ),
      elevation: MaterialStateProperty.all(
        elevation, //默认不显示,设为0;如果需要显示,系统默认是2
      ),
      side: MaterialStateProperty.all(
        BorderSide(
          width: borderWidth, //边框大小
          color: borderColor, //边框颜色
          style: BorderStyle.solid, //显示格式
        ),
      ),
      //todo 待完善
      //暂时找不到好的button圆角的方式,所以完全用系统自带的效果
      // shape: MaterialStateProperty.all(
      //     /*这种方式可以自定义圆角大小,但是不平滑,是棱形*/
      //     BeveledRectangleBorder(
      //   borderRadius: BorderRadius.circular(radius ?? 0), //圆角弧度
      // )),

      // ElevatedButton去除内置padding,否则text可能会转行
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: MaterialStateProperty.all(const Size(0, 0)),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
    ),
    onPressed: () {
      if (onPressed != null && enable == true) {
        onPressed();
      } //禁用后点击事件无法触发
    },
    child: child ?? Text(title ?? ''),
  );
}
