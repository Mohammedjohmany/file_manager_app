import 'dart:io';

import 'package:file_manager_app/presentation/bloc/file_bloc_bloc.dart';
import 'package:file_manager_app/presentation/bloc/file_bloc_event.dart';
import 'package:file_manager_app/presentation/bloc/file_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Manager'),
      ),
      body: BlocBuilder<FileManagerBloc, FileManagerState>(
        builder: (context, state) {
          if (state is FileManagerLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FileManagerLoaded) {
            return ListView.builder(
              itemCount: state.files.length,
              itemBuilder: (context, index) {
                final file = state.files[index];
                return ListTile(
                  title: Text(file.path.split('/').last),
                  subtitle: Text(file.statSync().size.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context.read<FileManagerBloc>().add(DeleteFileEvent(file.path));
                    },
                  ),
                );
              },
            );
          } else if (state is FileManagerError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Press the button to load files'));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              
              final currentPath = context.read<FileManagerBloc>().currentPath;
              final parentPath = Directory(currentPath).parent.path;
              context.read<FileManagerBloc>().add(LoadFiles(parentPath));
            },
            child: Icon(Icons.arrow_back),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              
              _showCreateFileDialog(context);
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
             
              context.read<FileManagerBloc>().add(SortFilesEvent());
            },
            child: Icon(Icons.sort),
          ),
        ],
      ),
    );
  }

  void _showCreateFileDialog(BuildContext context) {
    final TextEditingController fileNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create File'),
          content: TextField(
            controller: fileNameController,
            decoration: InputDecoration(hintText: 'Enter file name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final fileName = fileNameController.text;
                if (fileName.isNotEmpty) {
                  final currentPath = context.read<FileManagerBloc>().currentPath;
                  context.read<FileManagerBloc>().add(CreateFileEvent(currentPath, fileName));
                  Navigator.pop(context);
                }
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}