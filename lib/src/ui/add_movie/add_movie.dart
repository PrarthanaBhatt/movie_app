import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app/src/components/widgets/common_app_button.dart';
import 'package:movie_app/src/components/widgets/common_text_form_field.dart';
import 'package:movie_app/src/models/movie.dart';
import 'package:movie_app/src/utils/helpers/movie_sql_helper.dart';

class AddMovie extends ConsumerStatefulWidget {
  const AddMovie({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddMovieState();
}

class _AddMovieState extends ConsumerState<AddMovie> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController movieNameController = TextEditingController();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28282B),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          "Add Movie",
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            color: Color(0xFFF1F1F1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black45,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonTextFormField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                    FilteringTextInputFormatter.deny(RegExp(r"^\s*")),
                  ],
                  labelText: 'Movie Name',
                  controller: movieNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter movie name';
                    }
                    return null;
                  },
                ),
                if (image != null)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: FileImage(image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (image == null)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: IconButton(
                      padding: const EdgeInsets.all(10.0),
                      icon: const Icon(Icons.add_a_photo_outlined,
                          color: Color(0xFFF1F1F1), size: 55.0),
                      onPressed: () async {
                        try {
                          final XFile? xFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          if (xFile == null) return;
                          setState(() => image = File(xFile.path));
                        } on PlatformException catch (e) {
                          print('Failed to pick image: $e');
                        }
                      },
                    ),
                  ),
                CommonAppButton(
                  text: 'Add',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //INFO: Below code when adding new data using Movie model and rendering UI using statenotifierprovider
                      // final holder = Movie(
                      //     title: movieNameController.text,
                      //     posterPath: "",
                      //     overview: "",
                      //     backdropPath: "",
                      //     releaseDate: "",
                      //     originalLanguage: "",
                      //     originalTitle: movieNameController.text,
                      //     imagePath: image);

                      // Navigator.pop(context, holder);

                      //INFO: Below code when need to add new record to the database and rendering list from DB
                      const String holderValue = "Item added";
                      MovieSQLHelper.createItem(movieNameController.text, "",
                          "Random Test image description ", "", "", "en", "");
                      Navigator.pop(context, holderValue);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to add new movie!')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
