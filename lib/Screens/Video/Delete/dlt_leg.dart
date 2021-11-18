import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Components/appbar.dart';
import 'package:healthy_lux_admin/Components/dlt_video_body.dart';
import 'package:healthy_lux_admin/Model/video_api.dart';
import 'package:healthy_lux_admin/Model/video_file.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';

class DeleteLeg extends StatefulWidget {
  const DeleteLeg({Key? key}) : super(key: key);

  @override
  _DeleteLegState createState() => _DeleteLegState();
}

class _DeleteLegState extends State<DeleteLeg> {
  late Future<List<VideoFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = VideoApi.listAll('videoLeg/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: BuildAppBar(
            title: 'Leg Video',
            backButton: true,
            action: false,
            folder: false,
          ),
        ),
        body: deleteLegBody());
  }

  Widget deleteLegBody() {
    return DeleteVideoBody(futureFiles: futureFiles);
  }
}
