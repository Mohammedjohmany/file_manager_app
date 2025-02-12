

import 'package:file_manager_app/domain/repository/file_repo.dart';

class CreateFile {
  final FileManagerRepository repository;

  CreateFile(this.repository);

  Future<void> call(String path, String fileName) async {
    return repository.createFile(path, fileName);
  }
}