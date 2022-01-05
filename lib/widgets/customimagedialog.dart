import 'package:flutter/material.dart';

class CustomImagePickDialog extends StatelessWidget {
  final void Function() cameraimage;
  final void Function() galleryimage;

  const CustomImagePickDialog(
      {Key? key, required this.cameraimage, required this.galleryimage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Container(
        height: 188,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          onPressed: () {
            cameraimage();

            Navigator.pop(context);
          },
          child: Text("Camera"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.redAccent,
          ),
          onPressed: () {
            galleryimage();
            Navigator.pop(context);
          },
          child: Text("Gallery"),
        ),
      ],
    );
  }
}
