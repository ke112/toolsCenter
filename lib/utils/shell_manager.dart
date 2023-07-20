import 'dart:io';

import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';

class ShellManager {
  //目录路径是否为git仓库
  Future<bool> isGitRepository(String repositoryPath) async {
    var result = await Shell().run('find $repositoryPath -maxdepth 1 -name ".git"');
    if (result.first.exitCode == 0) {
      return result.first.stdout.toString().isNotEmpty;
    } else {
      return false;
    }
  }

  /// 执行shell语句
  /// 如果需要传参数,直接在命令后空一格带上 eg: var result = shell.run('your_script.sh param1 param2');
  /// 或者可以卸载一个数组中 var params = ['param1', 'param2']; var result = shell.run('your_script.sh', params);
  /// 超时时间?
  Future<String?> run(String shellCommand) async {
    var result = await Shell().run(shellCommand);
    if (result.first.exitCode == 0) {
      return result.first.stdout.toString();
    } else {
      debugPrint('Error: ${result.first.errText}');
      return null;
    }
  }

  Future<String> run2(String shellCommand, {List<String>? params}) async {
    ProcessResult result = await Process.run(shellCommand, params ?? []);
    // 打印结果
    return result.stdout.toString();
  }
}
