import 'package:flutter/material.dart';

class TitleDescriptionTile extends StatelessWidget {
  final String title;
  final String description;
  final Widget actionButton;

  TitleDescriptionTile({
    @required this.title,
    @required this.description,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                ),
              ),
              Text(
                description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ],
          ),),
          if (actionButton != null) actionButton,
        ],
      ),
    );
  }
}
