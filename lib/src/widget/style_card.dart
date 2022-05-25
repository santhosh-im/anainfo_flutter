import 'package:flutter/material.dart';


class StyleCard extends StatelessWidget {
  final Image image;
  final String title;
  final String description;

  const StyleCard(
      {required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
               Colors.white70,
                    Colors.white70
              ])),
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.65,
                    child: image,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ));
  }

}
