

import 'dart:io';

import 'package:file_manager_app/domain/repository/file_repo.dart';

class GetFiles {
  final FileManagerRepository repository;

  GetFiles(this.repository);

  Future<List<FileSystemEntity>> call(String path) async {
    return repository.getFiles(path);
  }
}