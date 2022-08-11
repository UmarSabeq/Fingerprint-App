import 'package:fingerprint/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../auth_cubit/auth_cubit.dart';
import '../auth_cubit/auth_state.dart';
import '../widget/custom_text_filed.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  late final TextEditingController phone;
  late final TextEditingController password;
  late final GlobalKey<FormState> _formKey;

  late bool hidePassword;
  late bool showLoading;
  // bool hideF = true;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    phone = TextEditingController();
    password = TextEditingController();

    // BlocProvider.of<AuthCubit>(context).hideFeatures().then((e) {
    //   hideF = HiveHelper().getData("HF");
    // });
    hidePassword = true;
    showLoading = false;
  }

  @override
  void dispose() {
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(state.massage)));
        }
        if (state is AuthSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const NavBar()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: 200,
                        height: 300,
                        child: Image.asset("assets/images/logo.png"),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          local!.greeting,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          local.pleaseSignIn,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        SizedBox(height: size.height * 0.07),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextFiled(
                                controller: phone,
                                textInputType: TextInputType.phone,
                                hint: local.phoneNumber,
                                password: false,
                                icon: Icons.phone_android,
                                validat: local.pleaseEnterPhone,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: size.height * 0.01),
                              CustomTextFiled(
                                controller: password,
                                textInputType: TextInputType.visiblePassword,
                                hint: local.password,
                                password: hidePassword,
                                showPasswordWidget: IconButton(
                                  icon: Icon(
                                    hidePassword == true
                                        ? CupertinoIcons.eye_slash
                                        : CupertinoIcons.eye,
                                    color: Colors.grey[700],
                                  ),
                                  onPressed: () => setState(
                                      () => hidePassword = !hidePassword),
                                ),
                                icon: Icons.shield,
                                validat: local.pleaseEnterPass,
                                textInputAction: TextInputAction.done,
                                // onSubmit: (value) => _signIn(),
                              ),
                              // hideF
                              //     ? Align(
                              //         alignment: Alignment.topRight,
                              //         child: InkWell(
                              //           onTap: () {
                              //             Navigator.push(
                              //               context,
                              //               MaterialPageRoute<void>(
                              //                 builder: (BuildContext
                              //                         context) =>
                              //                     const ForgetPassword(),
                              //               ),
                              //             );
                              //           },
                              //           child: Text(
                              //             "Forget Password ? ",
                              //             style: Theme.of(context)
                              //                 .textTheme
                              //                 .bodyText2!
                              //                 .copyWith(
                              //                     color: Theme.of(context)
                              //                         .colorScheme
                              //                         .primary),
                              //           ),
                              //         ),
                              //       )
                              //     : const SizedBox.shrink()
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        state is AuthLoading
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : SizedBox(
                                width: size.width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20.0)),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .singIn(
                                              phone: phone.text,
                                              password: password.text);
                                    }
                                  },
                                  child: Text(local.signIn),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        // hideF
                        //     ? InkWell(
                        //         onTap: () {
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute<void>(
                        //               builder: (BuildContext context) =>
                        //                   const Register(),
                        //             ),
                        //           );
                        //         },
                        //         child: Text(
                        //           "Create New Account ?",
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .bodyText1!
                        //               .copyWith(
                        //                   color: Theme.of(context)
                        //                       .colorScheme
                        //                       .primary),
                        //         ))
                        //     : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
