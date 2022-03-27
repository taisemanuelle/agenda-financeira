import 'dart:io';
import 'package:agenda_app/constFiles/colors.dart';
import 'package:flutter/material.dart';

class BarApp extends StatelessWidget {
  static File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: whiteColor,
        //decoration:
        // BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0))),
        child: Row(
          children: [
            Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: imageFile == null
                  ? Icon(Icons.app_registration, size: 35, color: whiteColor)
                  : Image.file(imageFile!, fit: BoxFit.contain),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Container(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Agenda Financeira",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                          color: blackColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
