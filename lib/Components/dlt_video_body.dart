import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Components/alert_dialog.dart';
import 'package:healthy_lux_admin/Model/video_file.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';

// ignore: must_be_immutable
class DeleteVideoBody extends StatefulWidget {
  Future<List<VideoFile>> futureFiles;
  DeleteVideoBody({Key? key, required this.futureFiles}) : super(key: key);

  @override
  _DeleteVideoBodyState createState() => _DeleteVideoBodyState();
}

class _DeleteVideoBodyState extends State<DeleteVideoBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VideoFile>>(
      future: widget.futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('Some error occurred!'));
            } else {
              final files = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(files!.length),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];

                        return ListTile(
                          title: Text(file.name,
                              style: AppTheme.defaultTextStyle14White(true)
                                  .copyWith(
                                decoration: TextDecoration.underline,
                                color: AppTheme.blueColor,
                              )),
                          onTap: () async {
                            final res = await showDialog<bool>(
                              context: context,
                              builder: (_) => BuildAlertDialog()
                                  .buildYesNoAlertDialog(
                                      context,
                                      "Confirmation",
                                      "Are you really wanted to delete this file?"),
                            );

                            if (res!) {
                              await file.ref.delete();
                              files.removeAt(index);
                              setState(() {});
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
        }
      },
    );
  }

  Widget buildHeader(int length) => ListTile(
        tileColor: AppTheme.blueColor,
        leading: const SizedBox(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: AppTheme.whiteColor,
          ),
        ),
        title: Text('$length Files',
            style: AppTheme.defaultTextStyle20White(true)),
      );
}
