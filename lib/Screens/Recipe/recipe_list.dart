import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_lux_admin/Components/alert_dialog.dart';
import 'package:healthy_lux_admin/Components/appbar.dart';
import 'package:healthy_lux_admin/Components/text_field.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  CollectionReference ref = FirebaseFirestore.instance.collection("recipe");

  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  updateRecipe(AsyncSnapshot<QuerySnapshot> snapshot, index) {
    snapshot.data!.docs[index].reference.update({
      "name": nameController.text,
      "calories": caloriesController.text,
      "ingredient": ingredientController.text,
      "instruction": instructionController.text,
      "imageUrl": imageUrlController.text,
    }).whenComplete(() {
      BuildAlertDialog()
          .displayToastMessage("Recipe successfully updated", context);
      Navigator.pop(context);
    });
  }

  updateChecking(AsyncSnapshot<QuerySnapshot> snapshot, index) {
    if (nameController.text.isEmpty) {
      BuildAlertDialog()
          .displayToastMessage("Name of the meals are required", context);
    } else if (caloriesController.text.isEmpty) {
      BuildAlertDialog()
          .displayToastMessage("Calories of the meals are required", context);
    } else if (ingredientController.text.isEmpty) {
      BuildAlertDialog()
          .displayToastMessage("Ingredient of the meals are required", context);
    } else if (instructionController.text.isEmpty) {
      BuildAlertDialog().displayToastMessage(
          "Instruction of the meals are required", context);
    } else if (imageUrlController.text.isEmpty) {
      BuildAlertDialog()
          .displayToastMessage("url of the image are required", context);
    } else {
      updateRecipe(snapshot, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.darkblueColor,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: BuildAppBar(
            title: 'Home',
            backButton: true,
            action: true,
            folder: true,
            route: RecipeList(),
          ),
        ),
        body: recipelistBody(ref));
  }

  Widget recipelistBody(ref) {
    return StreamBuilder(
      stream: ref.snapshots(),
      builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: 180,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: ListTile(
                        leading: IconButton(
                          icon: const Icon(Icons.edit),
                          color: AppTheme.whiteColor,
                          onPressed: () {
                            nameController.text = doc['name'];
                            caloriesController.text = doc['calories'];
                            ingredientController.text = doc['ingredient'];
                            instructionController.text = doc['instruction'];
                            imageUrlController.text = doc['imageUrl'];
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                    child: recipeDialogBody(snapshot, index)));
                          },
                        ),
                        title: Text(doc['name'],
                            style: AppTheme.defaultTextStyle20White(true)),
                        subtitle: null,
                        trailing: Image.network(
                          doc['imageUrl'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              });
        } else {
          return const Text('');
        }
      },
    );
  }

  Widget recipeDialogBody(AsyncSnapshot<QuerySnapshot> snapshot, index) {
    return Container(
      color: AppTheme.lightblueColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            BuildTextField()
                .buildTextField(nameController, "Name", false, true),
            BuildTextField()
                .buildTextField(caloriesController, "Calories", false, true),
            BuildTextField()
                .buildTextField(ingredientController, "Ingredient", true, true),
            BuildTextField().buildTextField(
                instructionController, "Instruction", true, true),
            BuildTextField()
                .buildTextField(imageUrlController, "Image Url", false, true),
            // ignore: deprecated_member_use
            FlatButton(
                child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("Update Recipe")),
                color: AppTheme.lightgreenColor,
                onPressed: () {
                  updateChecking(snapshot, index);
                }),
            const SizedBox(
              height: 20.0,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Delete Recipe',
                    style: AppTheme.defaultTextStyle16White(true)),
              ),
              color: AppTheme.redColor,
              onPressed: () async {
                final res = await showDialog(
                    context: context,
                    builder: (_) => BuildAlertDialog().buildYesNoAlertDialog(
                        context,
                        "Delete Confirmation",
                        "Do you wanted to delete this recipe"));
                if (res) {
                  snapshot.data!.docs[index].reference
                      .delete()
                      .whenComplete(() => Navigator.pop(context));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
