import 'dart:io';

import 'package:file_manager_app/domain/use_cases/create_file.dart';
import 'package:file_manager_app/domain/use_cases/delete_file';
import 'package:file_manager_app/domain/use_cases/get_file.dart';
import 'package:file_manager_app/domain/use_cases/sort_file.dart';
import 'package:file_manager_app/presentation/bloc/file_bloc_event.dart';
import 'package:file_manager_app/presentation/bloc/file_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FileManagerBloc extends Bloc<FileManagerEvent, FileManagerState> {
  final GetFiles getFiles;
  final CreateFile createFile;
  final DeleteFile deleteFile;
  final SortFiles sortFiles;

  String currentPath = '/';

  FileManagerBloc({
    required this.getFiles,
    required this.createFile,
    required this.deleteFile,
    required this.sortFiles,
  }) : super(FileManagerInitial()) {
    on<LoadFiles>((event, emit) async {
      emit(FileManagerLoading());
      try {
        final files = await getFiles(event.path);
        currentPath = event.path;
        emit(FileManagerLoaded(files));
      } catch (e) {
        emit(FileManagerError('Failed to load files: ${e.toString()}'));
      }
    });

    on<CreateFileEvent>((event, emit) async {
      try {
        await createFile(event.path, event.fileName);
        add(LoadFiles(event.path)); 
      } catch (e) {
        emit(FileManagerError('Failed to create file: ${e.toString()}'));
      }
    });

    on<DeleteFileEvent>((event, emit) async {
      try {
        await deleteFile(event.path);
        add(LoadFiles(Directory(event.path).parent.path)); 
      } catch (e) {
        emit(FileManagerError('Failed to delete file: ${e.toString()}'));
      }
    });

    on<SortFilesEvent>((event, emit) {
      if (state is FileManagerLoaded) {
        final sortedFiles = sortFiles((state as FileManagerLoaded).files);
        emit(FileManagerLoaded(sortedFiles));
      }
    });
  }
}