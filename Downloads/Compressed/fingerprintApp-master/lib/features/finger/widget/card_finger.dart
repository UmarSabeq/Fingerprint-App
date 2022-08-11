import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CardFinger extends StatelessWidget {
  const CardFinger(
      {Key? key,
      required this.ontap,
      required this.title,
      required this.stitle,
      required this.color,
      required this.nImage})
      : super(key: key);
  final Function()? ontap;
  final String title;
  final String stitle;

  final Color? color;
  final String nImage;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.23,
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(1, 8),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: color,
                        )),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.15,
                child: Center(
                  child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                                  // shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(20)),
                                  content: Text(
                                    stitle,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: Text(t!.cancel),
                                    ),
                                    TextButton(
                                      onPressed: ontap,
                                      child: Text(t.ok),
                                    ),
                                  ],
                                )).then((value) => Navigator.pop(context));
                      },
                      child: Lottie.asset("assets/images/$nImage.json",
                          fit: BoxFit.fitWidth)),
                )),
          ],
        ),
      ),
    );
  }
}
