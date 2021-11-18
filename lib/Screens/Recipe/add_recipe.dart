import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:healthy_lux_admin/Components/appbar.dart';
import 'package:healthy_lux_admin/Components/text_field.dart';
import 'package:healthy_lux_admin/Preferences/app_theme.dart';
import 'package:healthy_lux_admin/Screens/Recipe/recipe_list.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  TextEditingController ingredientController = TextEditingController();
  TextEditingController instructionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  late Map<String, dynamic> recipeToAdd;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("recipe");

  addRecipe() {
    recipeToAdd = {
      "name": nameController.text,
      "calories": caloriesController.text,
      "ingredient": ingredientController.text,
      "instruction": instructionController.text,
      "imageUrl": imageUrlController.text,
    };

    collectionReference
        .add(recipeToAdd)
        // ignore: avoid_print
        .whenComplete(() => print('Recipe are added'));
  }

  saveChecking() {
    if (nameController.text.isEmpty) {
      displayToastMessage("Name of the meals are required", context);
    } else if (caloriesController.text.isEmpty) {
      displayToastMessage("Calories of the meals are required", context);
    } else if (ingredientController.text.isEmpty) {
      displayToastMessage("Ingredient of the meals are required", context);
    } else if (instructionController.text.isEmpty) {
      displayToastMessage("Instruction of the meals are required", context);
    } else if (imageUrlController.text.isEmpty) {
      displayToastMessage("url of the image are required", context);
    } else {
      addRecipe();
      displayToastMessage("Recipe added successfully", context);
      nameController.clear();
      caloriesController.clear();
      instructionController.clear();
      ingredientController.clear();
      imageUrlController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.lightblueColor,
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
        body: addrecipeBody());
  }

  Widget addrecipeBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            BuildTextField()
                .buildTextField(nameController, "Name", false, false),
            BuildTextField()
                .buildTextField(caloriesController, "Calories", false, false),
            BuildTextField().buildTextField(
                ingredientController, "Ingredient", true, false),
            BuildTextField().buildTextField(
                instructionController, "Instruction", true, false),
            BuildTextField()
                .buildTextField(imageUrlController, "Image Url", false, false),
            // ignore: deprecated_member_use
            FlatButton(
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Add Recipe'),
                ),
                color: AppTheme.lightgreenColor,
                onPressed: () {
                  saveChecking();
                }),
          ],
        ),
      ),
    );
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
