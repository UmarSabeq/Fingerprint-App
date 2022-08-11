import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/fade_route.dart';
import '../../../nav_bar.dart';
import '../user_data_cubit/user_data_cubit.dart';
import '../user_data_cubit/user_data_state.dart';

class UserDataView extends StatelessWidget {
  const UserDataView({Key? key, required this.userFtra}) : super(key: key);
  final ValueChanged<int> userFtra;
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return BlocConsumer<UserDataCubit, UserDataState>(
        builder: (context, state) {
      if (state is GetUserDataLoading) {
        return Container(
          padding: const EdgeInsets.only(right: 30.0, left: 20.0, top: 100.0),
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView.separated(
              itemBuilder: (context, index) => Container(
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
              separatorBuilder: (context, index) =>
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              itemCount: 5),
        );
      } else if (state is GetUserDataLoaded) {
        userFtra(state.userDataModel.data.ftra!);
        log(state.userDataModel.data.ftra.toString());
        return Padding(
          padding: const EdgeInsets.only(right: 30.0, left: 20.0, top: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local!.welcom,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.006),
              Text(
                state.userDataModel.data.fullName,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.006),
              Text(
                "${local.jobnumber} ( ${state.userDataModel.data.mid} )",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.006),
              Text(
                "${local.numAccount} : " + state.userDataModel.data.phoneNum,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.006),
              Text(
                "${local.workplace} : " + state.userDataModel.data.profession,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        );
      }
      return Container();
    }, listener: ((context, state) {
      // if (state is GetUserDataLoaded) {
      //   Navigator.of(context).pushAndRemoveUntil(
      //     FadeRoute(builder: (BuildContext context) => const NavBar()),
      //     ModalRoute.withName('/'),
      //   );
      // }
    }));
  }
}
