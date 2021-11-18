import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Components/appbar.dart';
import 'package:healthy_lux_admin/Components/dlt_video_body.dart';
import 'package:healthy_lux_admin/Model/video_api.dart';
import 'package:healthy_lux_admin/Model/video_file.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';

class DeleteBack extends StatefulWidget {
  const DeleteBack({Key? key}) : super(key: key);

  @override
  _DeleteBackState createState() => _DeleteBackState();
}

class _DeleteBackState extends State<DeleteBack> {
  late Future<List<VideoFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = VideoApi.listAll('videoBack/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: BuildAppBar(
            title: 'Back Video',
            backButton: true,
            action: false,
            folder: false,
          ),
        ),
        body: deleteBackBody());
  }

  Widget deleteBackBody() {
    return DeleteVideoBody(futureFiles: futureFiles);
  }
}
