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

  //执行shell语句
  Future<dynamic> run(String shellCommand) async {
    var result = await Shell().run(shellCommand);
    if (result.first.exitCode == 0) {
      return result.first.stdout;
    } else {
      debugPrint('Error: ${result.first.errText}');
      return null;
    }
  }
}
