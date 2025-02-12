

import 'dart:io';

import 'package:file_manager_app/domain/repository/file_repo.dart';

class SortFiles {
  final FileManagerRepository repository;

  SortFiles(this.repository);

  List<FileSystemEntity> call(List<FileSystemEntity> files) {
    return repository.sortFiles(files);
  }
}