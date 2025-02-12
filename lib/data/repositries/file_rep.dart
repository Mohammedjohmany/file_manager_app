import 'dart:io';

import 'package:file_manager_app/domain/repository/file_repo.dart';
class FileManagerRepositoryImpl implements FileManagerRepository {
  @override
  Future<void> createFile(String path, String fileName) async {
    final file = File('$path/$fileName');
    await file.create();
  }

  @override
  Future<List<FileSystemEntity>> getFiles(String path) async {
    final directory = Directory(path);
    return directory.list().toList();
  }

  @override
  Future<void> deleteFile(String path) async {
    final entity = FileSystemEntity.isDirectorySync(path) ? Directory(path) : File(path);
    await entity.delete();
  }

  @override
  List<FileSystemEntity> sortFiles(List<FileSystemEntity> files) {
    files.sort((a, b) => a.path.split('/').last.compareTo(b.path.split('/').last));
    return files;
  }
}