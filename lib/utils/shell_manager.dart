import 'dart:io';

import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';

class ShellManager {
  /// 目录路径是否为git仓库
  Future<bool> isGitRepository(String repoPath) async {
    var result = await Shell().run('find $repoPath -maxdepth 1 -name ".git"');
    if (result.first.exitCode == 0) {
      return result.first.stdout.toString().isNotEmpty;
    } else {
      return false;
    }
  }

  /// 查找shell脚本的实际路径
  Future<String?> findScriptPath(String filename) async {
    var result = await Shell().run('find ${Directory.current.path} -name "$filename"');
    if (result.first.exitCode == 0) {
      return result.first.stdout.toString();
    } else {
      return null;
    }
  }

  /// 执行shell语句
  /// 如果需要传参数,直接在命令后空一格带上 eg: var result = shell.run('your_script.sh param1 param2');
  /// 或者可以卸载一个数组中 var params = ['param1', 'param2']; var result = shell.run('your_script.sh', params);
  /// 超时时间?
  Future<String?> run(String script) async {
    var result = await Shell().run(script);
    if (result.first.exitCode == 0) {
      return result.first.stdout.toString();
    } else {
      debugPrint('Error: ${result.first.errText}');
      return null;
    }
  }

  /// 跑某个脚本
  /// script name为脚本名称
  Future<String?> runScript(String script, {List<String>? args}) async {
    ProcessResult result = await Process.run(script, args ?? []);
    return result.stdout.toString();
  }
}
