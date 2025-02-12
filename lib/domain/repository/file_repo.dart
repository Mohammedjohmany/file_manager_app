import 'dart:io';

abstract class FileManagerRepository {
  Future<List<FileSystemEntity>> getFiles(String path);
  Future<void> createFile(String path, String fileName);
  Future<void> deleteFile(String path);
  List<FileSystemEntity> sortFiles(List<FileSystemEntity> files);
}