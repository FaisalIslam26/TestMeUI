import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String id;
  final void Function(String) ontap;
  const CustomAlertDialog({Key? key, required this.id, required this.ontap})
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
            ontap(id);
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.redAccent,
          ),
          onPressed: () {
            ontap(id);
            Navigator.pop(context);
          },
          child: Text("Confirm"),
        ),
      ],
    );
  }
}
