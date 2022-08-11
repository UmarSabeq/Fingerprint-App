import 'package:flutter/material.dart';

class CardTileReport extends StatelessWidget {
  const CardTileReport({Key? key, required this.title, required this.hour})
      : super(key: key);
  final String title;
  final String hour;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        leading: Icon(
          Icons.watch_later_outlined,
          color: Theme.of(context).colorScheme.primary,
        ),
        trailing: Text(
          hour,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.red),
        ),
      ),
      const Divider()
    ]);
  }
}
