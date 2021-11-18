import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Components/appbar.dart';
import 'package:healthy_lux_admin/Components/dlt_video_body.dart';
import 'package:healthy_lux_admin/Model/video_api.dart';
import 'package:healthy_lux_admin/Model/video_file.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';

class DeletePectoral extends StatefulWidget {
  const DeletePectoral({Key? key}) : super(key: key);

  @override
  _DeletePectoralState createState() => _DeletePectoralState();
}

class _DeletePectoralState extends State<DeletePectoral> {
  late Future<List<VideoFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = VideoApi.listAll('videoPectoral/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: BuildAppBar(
            title: 'Pectoral Video',
            backButton: true,
            action: false,
            folder: false,
          ),
        ),
        body: deletePectoralBody());
  }

  Widget deletePectoralBody() {
    return DeleteVideoBody(futureFiles: futureFiles);
  }
}
