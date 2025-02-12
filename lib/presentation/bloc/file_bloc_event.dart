import 'package:flutter/cupertino.dart';

//part of 'file_manager_bloc.dart';

@immutable
sealed class FileManagerEvent {}

class LoadFiles extends FileManagerEvent {
  final String path;
  LoadFiles(this.path);
}

class CreateFileEvent extends FileManagerEvent {
  final String path;
  final String fileName;
  CreateFileEvent(this.path, this.fileName);
}

class DeleteFileEvent extends FileManagerEvent {
  final String path;
  DeleteFileEvent(this.path);
}

class SortFilesEvent extends FileManagerEvent {}