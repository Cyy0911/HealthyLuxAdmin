import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Components/appbar.dart';
import 'package:healthy_lux_admin/Components/dlt_video_body.dart';
import 'package:healthy_lux_admin/Model/video_api.dart';
import 'package:healthy_lux_admin/Model/video_file.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';

class DeleteArm extends StatefulWidget {
  const DeleteArm({Key? key}) : super(key: key);

  @override
  _DeleteArmState createState() => _DeleteArmState();
}

class _DeleteArmState extends State<DeleteArm> {
  late Future<List<VideoFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = VideoApi.listAll('videoArm/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: BuildAppBar(
            title: 'Arm Video',
            backButton: true,
            action: false,
            folder: false,
          ),
        ),
        body: deleteArmBody());
  }

  Widget deleteArmBody() {
    return DeleteVideoBody(futureFiles: futureFiles);
  }
}
