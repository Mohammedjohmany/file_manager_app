import 'dart:io';

import 'package:file_manager_app/core/error.dart';


class LocalFileDataSource {
  Future<List<FileSystemEntity>> getFiles(String path) async {
    try {
      final directory = Directory(path);
      return directory.list().toList();
    } on FileSystemException catch (e) {
      throw FileManagerException(e.message);
    }
  }

  Future<void> createFolder(String path, String name) async {
    try {
      final newFolder = Directory('$path/$name');
      await newFolder.create();
    } on FileSystemException catch (e) {
      throw FileManagerException(e.message);
    }
  }
}