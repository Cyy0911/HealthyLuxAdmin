// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../Preferences/app_theme.dart';

class BuildAppBar extends StatefulWidget {
  final title;
  final backButton;
  final action;
  final folder;
  final route;

  const BuildAppBar(
      {Key? key,
      required this.title,
      required this.backButton,
      required this.action,
      this.folder,
      this.route})
      : super(key: key);

  @override
  _BuildAppBarState createState() => _BuildAppBarState();
}

class _BuildAppBarState extends State<BuildAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.darkblueColor,
      title: Text(widget.title),
      centerTitle: true,
      leading: Visibility(
        visible: widget.backButton,
        child: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.whiteColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        Visibility(
            visible: widget.action,
            child: widget.folder
                ? IconButton(
                    icon: const Icon(
                      Icons.folder_open,
                      color: AppTheme.whiteColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => widget.route));
                    })
                : IconButton(
                    icon: const Icon(Icons.logout, color: AppTheme.whiteColor),
                    onPressed: () => Navigator.of(context).pop(),
                  )),
      ],
    );
  }
}
