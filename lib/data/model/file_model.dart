class FileModel {
  final String name;
  final String path;
  final int size;
  final DateTime lastModified;

  FileModel({
    required this.name,
    required this.path,
    required this.size,
    required this.lastModified,
  });
}