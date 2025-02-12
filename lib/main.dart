import 'package:file_manager_app/data/data_source/local_file_data_source.dart';
import 'package:file_manager_app/data/repositries/file_rep.dart';
import 'package:file_manager_app/domain/use_cases/create_file.dart';
import 'package:file_manager_app/domain/use_cases/delete_file';
import 'package:file_manager_app/domain/use_cases/get_file.dart';
import 'package:file_manager_app/domain/use_cases/sort_file.dart';
import 'package:file_manager_app/presentation/bloc/file_bloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_manager_app/presentation/pages/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Manager',
      home: BlocProvider(
        create: (context) => FileManagerBloc(
          getFiles: GetFiles(
            FileManagerRepositoryImpl(
              //localDataSource: LocalFileDataSource(),
            ),
          ),
          createFile: CreateFile(
            FileManagerRepositoryImpl(
             // localDataSource: LocalFileDataSource(),
            ),
          ),
          deleteFile: DeleteFile(
            FileManagerRepositoryImpl(
             // localDataSource: LocalFileDataSource(),
            ),
          ),
          sortFiles: SortFiles(
            FileManagerRepositoryImpl(
             // localDataSource: LocalFileDataSource(),
            ),
          ),
        ),
        child: HomeScreen(),
      ),
    );
  }
}