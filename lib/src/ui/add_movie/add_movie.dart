import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add Movie"),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    controller: movieNameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                      FilteringTextInputFormatter.deny(RegExp(r"^\s*")),
                    ],
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: UnderlineInputBorder(),
                      labelText: "Movie Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter movie name';
                      }
                      return null;
                    },
                  ),
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
                      icon: const Icon(Icons.add_a_photo_outlined, size: 55.0),
                      onPressed: () async {
                        try {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image == null) return;
                          final imageTemp = File(image.path);
                          setState(() => this.image = imageTemp);
                        } on PlatformException catch (e) {
                          print('Failed to pick image: $e');
                        }
                      },
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12.0),
                  child: Center(
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            movieNameController.text;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(movieNameController.text)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Failed to add new movie!')),
                            );
                          }
                        },
                        child: const Text(
                          'Add',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
