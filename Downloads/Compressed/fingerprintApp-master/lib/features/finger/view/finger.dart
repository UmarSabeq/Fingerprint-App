import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constant/privicy.dart';
import '../../../core/localization/language_cubit.dart';

import '../../management/time_sheet_cubit/time_sheet_cubit.dart';
import '../../user_data/user_data_cubit/user_data_cubit.dart';
import '../../user_data/view/user_data_view.dart';
import '../finger_cubit/finger_cubit.dart';
import '../finger_cubit/finger_state.dart';
import '../widget/background_finger.dart';
import '../widget/shift_card.dart';

class FingerPrint extends StatefulWidget {
  const FingerPrint({Key? key}) : super(key: key);

  @override
  State<FingerPrint> createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  String textFinger = "تسجيل الحضور";
  int? ftra;
  String? locationError;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocConsumer<FingerCubit, FingerState>(
      listener: (context, state) {
        if (state is GetLocaionError) {
          switch (state.massage.toString()) {
            case "location Error : :  L1.":
              locationError = local!.locationDisabled;
              break;
            case "location Error : :  L2":
              locationError = local!.locationDenied;
              break;
            case "location Error : :  L3":
              locationError = local!.locatioDeniedEver;
              break;
          }
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: SizedBox(
                        height: 150,
                        child: Center(child: Text(locationError!))),
                  )).then((value) => Navigator.pop(context));
        }
        if (state is SingFingerError) {
          switch (state.massage.toString()) {
            case "allready signed in":
              locationError = local!.alreadySingin;
              break;
            default:
              locationError = local!.outOfLoction;
          }
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: SizedBox(
                      height: 150,
                      child: Center(child: Text(locationError!)),
                    ),
                  ));
        }
        if (state is SingOutFingerLoaded) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 60,
                              color: Colors.green[700],
                            ),
                            Text(
                              local!.successfullyregistered,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${local.earlydeparture} : ${state.data["go_early"]} \n ${local.extratime} : ${state.data["over_time"]}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.red[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
        }

        if (state is SingFingerLoaded) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 60,
                              color: Colors.green[700],
                            ),
                            Text(
                              local!.successfullyregistered,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${local.delayperiod} : ${state.data["daily_time"]}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.red[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<FingerCubit>(context);

        return Stack(
          children: [
            const BackgroundScreen(),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                height: MediaQuery.of(context).size.height * 0.18,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const AssetImage("assets/images/logo.png"),
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.9),
                          BlendMode.modulate,
                        ))),
              ),
            ),
            // Image.asset("assets/images/logo.png", opacity: ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: IconButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25))),
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const Privacy(),
                                      ),
                                    );
                                  },
                                  title: Text(local!.privacypolicy),
                                  leading: Icon(
                                    Icons.privacy_tip,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  onTap: () async {
                                    BlocProvider.of<LanguageCubit>(context)
                                        .selectEngLanguage()
                                        .then((value) {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  title: Text(local.lang),
                                  leading: Icon(
                                    Icons.language,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                // const Divider(),
                                // ListTile(
                                //   onTap: () async {
                                //     await HiveHelper().removeData("token");
                                //     Navigator.of(context).pushAndRemoveUntil(
                                //       MaterialPageRoute<void>(
                                //           builder: (BuildContext context) =>
                                //               const Signin()),
                                //       (route) => false,
                                //     );
                                //   },
                                //   title: Text(local.singout),
                                //   leading: Icon(
                                //     Icons.login_rounded,
                                //     color:
                                //         Theme.of(context).colorScheme.primary,
                                //   ),
                                // )
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.black87,
                    size: 30,
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserDataView(
                  userFtra: (value) {
                    ftra = value;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                BlocProvider.of<UserDataCubit>(context).ftra == 3
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ShiftCard(
                            ontapSigin: () async {
                              await cubit.getLocation().then(
                                (value) {
                                  log(cubit.locationlat.toString());
                                  cubit
                                      .fingerSingIn(
                                          lat: cubit.locationlat!,
                                          long: cubit.locationLon!)
                                      .then((value) {
                                    BlocProvider.of<TimeSheetCubit>(context)
                                        .getTimeSheetData();
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            },
                            ontapSigout: () async {
                              await cubit.getLocation().then(
                                (value) {
                                  log(cubit.locationlat.toString());
                                  cubit
                                      .fingerSingOut(
                                          lat: cubit.locationlat!,
                                          long: cubit.locationLon!)
                                      .then((value) {
                                    BlocProvider.of<TimeSheetCubit>(context)
                                        .getTimeSheetData();
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            },
                            title: local!.morning,
                            stitle: local.doregisterattendance,
                            color: Colors.black,
                            nImage: const FaIcon(
                              FontAwesomeIcons.cloudSun,
                              color: Colors.yellow,
                              size: 50,
                            ),
                            cardClolor: Colors.white70,
                          ),
                          ShiftCard(
                            ontapSigin: () async {
                              await cubit.getLocation().then(
                                (value) {
                                  log(cubit.locationlat.toString());
                                  cubit
                                      .fingerSingIn(
                                          lat: cubit.locationlat!,
                                          long: cubit.locationLon!)
                                      .then((value) {
                                    BlocProvider.of<TimeSheetCubit>(context)
                                        .getTimeSheetData();
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            },
                            ontapSigout: () async {
                              await cubit.getLocation().then(
                                (value) {
                                  log(cubit.locationlat.toString());
                                  cubit
                                      .fingerSingOut(
                                          lat: cubit.locationlat!,
                                          long: cubit.locationLon!)
                                      .then((value) {
                                    BlocProvider.of<TimeSheetCubit>(context)
                                        .getTimeSheetData();
                                  });
                                  Navigator.pop(context);
                                },
                              );
                            },
                            title: local.night,
                            stitle: local.docheckout,
                            color: Colors.white,
                            nImage: const FaIcon(
                              FontAwesomeIcons.moon,
                              size: 50,
                              color: Colors.white,
                            ),
                            cardClolor: Colors.black38,
                          ),
                        ],
                      )
                    : BlocProvider.of<UserDataCubit>(context).ftra == 1
                        ? Center(
                            child: ShiftCard(
                              ontapSigin: () async {
                                await cubit.getLocation().then(
                                  (value) {
                                    log(cubit.locationlat.toString());
                                    cubit
                                        .fingerSingIn(
                                            lat: cubit.locationlat!,
                                            long: cubit.locationLon!)
                                        .then((value) {
                                      BlocProvider.of<TimeSheetCubit>(context)
                                          .getTimeSheetData();
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              ontapSigout: () async {
                                await cubit.getLocation().then(
                                  (value) {
                                    log(cubit.locationlat.toString());
                                    cubit
                                        .fingerSingOut(
                                            lat: cubit.locationlat!,
                                            long: cubit.locationLon!)
                                        .then((value) {
                                      BlocProvider.of<TimeSheetCubit>(context)
                                          .getTimeSheetData();
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              title: local!.morning,
                              stitle: local.doregisterattendance,
                              color: Colors.black,
                              nImage: const FaIcon(
                                FontAwesomeIcons.cloudSun,
                                color: Colors.yellow,
                                size: 50,
                              ),
                              cardClolor: Colors.white70,
                            ),
                          )
                        : Center(
                            child: ShiftCard(
                              ontapSigin: () async {
                                await cubit.getLocation().then(
                                  (value) {
                                    log(cubit.locationlat.toString());
                                    cubit
                                        .fingerSingIn(
                                            lat: cubit.locationlat!,
                                            long: cubit.locationLon!)
                                        .then((value) {
                                      BlocProvider.of<TimeSheetCubit>(context)
                                          .getTimeSheetData();
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              ontapSigout: () async {
                                await cubit.getLocation().then(
                                  (value) {
                                    log(cubit.locationlat.toString());
                                    cubit
                                        .fingerSingOut(
                                            lat: cubit.locationlat!,
                                            long: cubit.locationLon!)
                                        .then((value) {
                                      BlocProvider.of<TimeSheetCubit>(context)
                                          .getTimeSheetData();
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              title: local!.night,
                              stitle: local.docheckout,
                              color: Colors.white,
                              nImage: const FaIcon(
                                FontAwesomeIcons.moon,
                                size: 50,
                                color: Colors.white,
                              ),
                              cardClolor: Colors.black38,
                            ),
                          ),
              ],
            ),
            state is SingFingerLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
