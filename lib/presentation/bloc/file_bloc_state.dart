import 'dart:io';

import 'package:flutter/cupertino.dart';

//part of 'file_manager_bloc.dart';

@immutable
sealed class FileManagerState {}

final class FileManagerInitial extends FileManagerState {}

final class FileManagerLoading extends FileManagerState {}

final class FileManagerLoaded extends FileManagerState {
  final List<FileSystemEntity> files;
  FileManagerLoaded(this.files);
}

final class FileManagerError extends FileManagerState {
  final String message;
  FileManagerError(this.message);
}