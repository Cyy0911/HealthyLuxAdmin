import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Components/appbar.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';
import 'package:healthy_lux_admin/Screens/Recipe/add_recipe.dart';

import 'Video/add_video.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xFF005AA7), Color(0xFFFdfdfd)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Scaffold(
          backgroundColor: AppTheme.transparentColor,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: BuildAppBar(
              title: 'Home',
              backButton: false,
              action: true,
              folder: false,
            ),
          ),
          body: homeBody(context)),
    );
  }

  Widget homeBody(BuildContext context) {
    return Column(
      children: [
        buildRecipeButton(context),
        const SizedBox(height: 20),
        buildVideoButton(context),
      ],
    );
  }

  Widget buildRecipeButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 250.0,
        width: 400.0,
        margin: const EdgeInsets.only(top: 50.0, left: 15),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(4.0, 4.0),
            )
          ],
          image: DecorationImage(
            image: AssetImage('images/ADMINRECIPE.PNG'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddRecipe()));
      },
    );
  }

  Widget buildVideoButton(context) {
    return GestureDetector(
      child: Container(
        width: 400,
        height: 250,
        margin: const EdgeInsets.only(top: 30.0, left: 15),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(4.0, 4.0),
            )
          ],
          image: DecorationImage(
            image: AssetImage('images/ADMINVIDEO.PNG'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddVideo()));
      },
    );
  }
}
