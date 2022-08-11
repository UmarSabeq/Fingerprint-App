import 'dart:math';

import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final t = AppLocalizations.of(context);

    return Stack(
      children: const [
        // Container(decoration: boxDecoration),

        // Pink Box
        Positioned(
          top: -120,
          left: 50,
          right: -40,
          child: _PinkBox(Alignment.bottomLeft, Alignment.topLeft),
        ),
        Positioned(
          bottom: -120,
          left: -40,
          right: 50,
          child: _PinkBox(Alignment.topLeft, Alignment.bottomLeft),
        ),
      ],
    );
  }
}

class _PinkBox extends StatelessWidget {
  const _PinkBox(this.top, this.bottom);
  final AlignmentGeometry top;
  final AlignmentGeometry bottom;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        height: 340,
        width: 320,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.0),
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(80),
          gradient: LinearGradient(
            begin: top,
            end: bottom,
            colors: <Color>[
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).colorScheme.primary.withOpacity(0.4),

              //Color(0xff3a3b55),
            ],
          ),
        ),
      ),
    );
  }
}
