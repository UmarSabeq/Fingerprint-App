import 'package:fingerprint/features/finger/widget/card_finger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShiftCard extends StatelessWidget {
  const ShiftCard(
      {Key? key,
      required this.ontapSigin,
      required this.ontapSigout,
      required this.title,
      required this.stitle,
      required this.color,
      required this.nImage,
      required this.cardClolor})
      : super(key: key);
  final Function()? ontapSigin;
  final Function()? ontapSigout;
  final String title;
  final String stitle;
  final Color cardClolor;

  final Color? color;
  final Widget nImage;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: cardClolor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 12,
              offset: const Offset(1, 8),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Center(
                child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                backgroundColor:
                                    Color.fromARGB(255, 221, 221, 221),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(20)),
                                content: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.16,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CardFinger(
                                          ontap: ontapSigin,
                                          title: t!.attendance,
                                          stitle: t.doregisterattendance,
                                          color: Colors.green,
                                          nImage: "in"),
                                      CardFinger(
                                          ontap: ontapSigout,
                                          title: t.departure,
                                          stitle: t.docheckout,
                                          color: Colors.red[900],
                                          nImage: "out")
                                    ],
                                  ),
                                ),
                              ));
                    },
                    child: nImage),
              ),
            ),
            FittedBox(
              child: Text(title,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: color,
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
