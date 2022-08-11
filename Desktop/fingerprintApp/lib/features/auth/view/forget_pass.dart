import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../auth_cubit/auth_cubit.dart';
import '../auth_cubit/auth_state.dart';
import '../widget/custom_text_filed.dart';
import 'login.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late final TextEditingController phone;
  late final TextEditingController password;

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
    final local = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red, content: Text(state.massage)));
        }
        if (state is AuthSuccess) {
          showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20)),
                    content: Text(
                      "password reset successfuly",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const Signin()),
                            (route) => false,
                          );
                        },
                        child: Text(local!.ok),
                      ),
                    ],
                  ));
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
                          "Forget Password ",
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
                              SizedBox(height: size.height * 0.01),
                              CustomTextFiled(
                                controller: phone,
                                textInputType: TextInputType.phone,
                                hint: local!.phoneNumber,
                                password: false,
                                icon: Icons.phone_android,
                                validat: local.pleaseEnterPhone,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: size.height * 0.01),
                              CustomTextFiled(
                                controller: password,
                                textInputType: TextInputType.visiblePassword,
                                hint: "New Password",
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
                                validat: local.pleaseEnterPass,
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
                                          .forgetPassWord(
                                        phone: phone.text,
                                        password: password.text,
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
                                  child: const Text("Reset"),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: size.width,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                padding: const EdgeInsets.all(20.0)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Signin(),
                                ),
                              );
                            },
                            child: Text(
                              "Cancel",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                          ),
                        ),
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
