/// @description:
/// @author
/// @date: 2023-06-19 19:44:35
class FunctionListState {
  //功能列表
  List<FunctionModel> dataList = [];
  //提示
  String tips = '''提示:\n
1:如果同时拖入多个项目,默认只识别第一个
  ''';

  //最新的拖入目录地址
  String currentDragPath = "";
  //功能列表选中的下标
  int currentIndex = -1;
  FunctionListState() {
    ///Initialize variables
    dataList.add(FunctionModel(0, '自动打包(旧版) > 1.自动打安卓/iOS包 2.目前只支持纯flutter的项目打包'));
    dataList.add(FunctionModel(1, '更新/提交代码 > 1.自动拉取Git代码,如果无日志不提交 2.解决了有新代码拉取时,自动合并成一个主干分支'));
  }
}

class FunctionModel {
  int index = 0;
  String title = '';

  FunctionModel(this.index, this.title);
}
