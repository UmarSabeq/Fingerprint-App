import 'package:fingerprint/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../auth_cubit/auth_cubit.dart';
import '../auth_cubit/auth_state.dart';
import '../widget/custom_text_filed.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController phone;
  late final TextEditingController password;
  late final TextEditingController name;
  late final TextEditingController cpassword;
  late final GlobalKey<FormState> _formKey;

  late bool hidePassword;
  late bool showLoading;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    phone = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    cpassword = TextEditingController();
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
    final t = AppLocalizations.of(context);
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
                    margin: EdgeInsets.only(
                      left: size.width * 0.06,
                      right: size.width * 0.06,
                      top: size.height * 0.2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Create Account ",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black, fontSize: 30),
                        ),
                        // Text(
                        //   "welcome in TsFinger",
                        //   style: Theme.of(context).textTheme.caption,
                        // ),
                        SizedBox(height: size.height * 0.04),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextFiled(
                                controller: name,
                                textInputType: TextInputType.name,
                                hint: "Name",
                                password: false,
                                icon: Icons.person,
                                validat: "please Enter your Name",
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: size.height * 0.01),
                              CustomTextFiled(
                                controller: phone,
                                textInputType: TextInputType.phone,
                                hint: t!.phoneNumber,
                                password: false,
                                icon: Icons.phone_android,
                                validat: t.pleaseEnterPhone,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: size.height * 0.01),
                              CustomTextFiled(
                                controller: password,
                                textInputType: TextInputType.visiblePassword,
                                hint: t.password,
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
                                validat: t.pleaseEnterPass,
                                textInputAction: TextInputAction.done,
                                // onSubmit: (value) => _Register(),
                              ),
                              SizedBox(height: size.height * 0.01),
                              CustomTextFiled(
                                controller: cpassword,
                                textInputType: TextInputType.visiblePassword,
                                hint: "password confirmation",
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
                                validat: t.pleaseEnterPass,
                                textInputAction: TextInputAction.done,
                                // onSubmit: (value) => _Register(),
                              ),
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
                                    if (_formKey.currentState!.validate() &&
                                        password.text == cpassword.text) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .singUp(
                                        phone: phone.text,
                                        password: password.text,
                                        name: name.text,
                                        passwordConfirmation: cpassword.text,
                                      );
                                    } else if (password.text !=
                                        cpassword.text) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: const SizedBox(
                                                  height: 100,
                                                  child: Center(
                                                      child: Text(
                                                    "The password and password confirmation must match",
                                                    textAlign: TextAlign.center,
                                                  )),
                                                ),
                                              ));
                                    }
                                  },
                                  child: const Text("Register"),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Signin(),
                                ),
                              );
                            },
                            child: Text(
                              "I already have an account ...",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            )),
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
