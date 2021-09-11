import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:image_picker/image_picker.dart';

class CreatQuizScreen extends StatefulWidget {
  const CreatQuizScreen({Key? key}) : super(key: key);

  @override
  _CreatQuizScreenState createState() => _CreatQuizScreenState();
}

class _CreatQuizScreenState extends State<CreatQuizScreen> {
  List<Question> listQuestion = <Question>[];
  late XFile imageFile;
  bool uploadImage = false;
  final ImagePicker picker = ImagePicker();
  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final pickedFile = await picker.pickImage(
        source: source,
      );
      setState(() {
        imageFile = pickedFile!;
        uploadImage = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: [
                  GestureDetector(
                    child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: uploadImage
                            ? Container(
                                child: Image.file(
                                  File(imageFile.path),
                                  height: 200,
                                  width: MediaQuery.of(context).size.width - 10,
                                ),
                              )
                            : Center(
                                child: Text(
                                'Upload image of quiz',
                                style: TextStyle(
                                    color: Colors.blue[900], fontSize: 25),
                              ))),
                    onTap: () {
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 1,
                      decoration: InputDecoration(
                          hintText: 'Enter title of quiz',
                          hintStyle:
                              TextStyle(color: Colors.black38, fontSize: 20)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width - 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 1,
                      decoration: InputDecoration(
                          hintText: 'Enter code of quiz',
                          hintStyle:
                              TextStyle(color: Colors.black38, fontSize: 20)),
                    ),
                  ),
                ],
              );
            },
            childCount: 1,
          ),
        ),

        SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container();
                },
              childCount: listQuestion.length,
                )
        ),
      ],
    );
  }
}
