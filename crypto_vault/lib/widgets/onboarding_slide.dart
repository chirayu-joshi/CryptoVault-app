import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingSlide extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  OnboardingSlide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });

  // List<TextSpan> get plainBoldText {
  //   String before;
  //   bool isBold = false;
  //   List<TextSpan> textSpanList = new List<TextSpan>();
  //
  //   for (int i = 0; i < description.length; ++i) {
  //     if (description[i] == '*') {
  //       if (isBold) {
  //         textSpanList.add(
  //           TextSpan(
  //             text: before,
  //             style: TextStyle(fontWeight: FontWeight.w700),
  //           ),
  //         );
  //       } else if (before != '') {
  //         textSpanList.add(
  //           TextSpan(
  //             text: before,
  //           ),
  //         );
  //       }
  //       isBold = !isBold;
  //       before = '';
  //     } else {
  //       before += description[i];
  //     }
  //   }
  //
  //   return textSpanList;
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 3,
          fit: FlexFit.tight,
          child: Container(
            padding: EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 24),
            child: Image.asset(
              imageUrl,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                // RichText(
                //   text: TextSpan(
                //     children: plainBoldText,
                //   ),
                // ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
