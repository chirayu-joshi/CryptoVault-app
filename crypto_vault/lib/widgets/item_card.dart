import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String description;
  final String type;

  ItemCard({
    @required this.title,
    @required description,
    @required this.type,
  }) : this.description = description.replaceAll('\n', '\t');

  @override
  Widget build(BuildContext context) {
    Color color;
    if (type == 'Password') {
      color = blue;
    } else {
      color = purple;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColorLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                title[0],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  color: textLight,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              height: 36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          if (type == 'Password')
            Container(
              height: 36,
              width: 36,
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.copy,
                    size: 22,
                  ),
                  color: textLight,
                  onPressed: () {},
                ),
              ),
            ),
        ],
      ),
    );
  }
}
