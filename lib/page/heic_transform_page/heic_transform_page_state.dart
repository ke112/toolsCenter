/// @description:
/// @author
/// @date: 2023-07-21 23:48:38
class HeicTransformPageState {
  bool isRemoveOrigin = false; //是否移除原图
  var options = ['jpeg', 'jpg', 'png', 'jp2', 'psd'];
  String selected = 'jpeg';
  String? drogPath; //要转换的文件夹路径

  HeicTransformPageState() {
    ///Initialize variables
  }
}
