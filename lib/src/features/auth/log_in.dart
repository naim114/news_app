import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/features/auth/sign_up.dart';
import 'package:news_app/src/services/helpers.dart';
import 'package:news_app/src/widgets/appbar/custom_appbar.dart';
import 'package:news_app/src/widgets/button/custom_button.dart';
import 'package:news_app/src/widgets/typography/custom_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../model/app_settings_model.dart';
import '../../services/auth_services.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final AuthService _authService = AuthService();

  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  bool _submitted = false;
  Widget _buttonChild = const Text('Log In');

  @override
  void initState() {
    super.initState();
    _submitted = false;
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        onPressed: () {},
        noBackButton: true,
        actions: [
          IconButton(
            icon: isDarkTheme(context)
                ? const Icon(CupertinoIcons.moon_fill)
                : const Icon(CupertinoIcons.sun_max_fill),
            color: getColorByBackground(context),
            onPressed: () => selectThemeMode(context),
          ),
        ],
      ),
      body: Consumer<AppSettingsModel?>(builder: (context, appSettings, child) {
        return appSettings == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: CachedNetworkImage(
                                imageUrl: appSettings.logoMainURL,
                                fit: BoxFit.contain,
                                height: 100,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/default_logo_main.png',
                                  fit: BoxFit.contain,
                                  height: 100,
                                ),
                              ),
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.only(bottom: 30.0),
                            //   child: Text(
                            //     "Log In",
                            //     style: TextStyle(
                            //       fontSize: 24,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CustomTextField(
                                controller: emailController,
                                icon: const Icon(CupertinoIcons.at),
                                labelText: 'Email',
                                errorText: _submitted == true &&
                                        emailController.text.isEmpty
                                    ? "Input can't be empty"
                                    : _submitted == true &&
                                            !validateEmail(emailController)
                                        ? "Please enter the correct email"
                                        : null,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: CustomTextField(
                                controller: passwordController,
                                icon: const Icon(CupertinoIcons.padlock),
                                labelText: 'Password',
                                isPassword: true,
                                errorText: _submitted == true &&
                                        passwordController.text.isEmpty
                                    ? "Input can't be empty"
                                    : null,
                              ),
                            ),
                            customButton(
                              child: _buttonChild,
                              onPressed: () async {
                                setState(() => _submitted = true);
                                setState(() => _buttonChild =
                                        const CircularProgressIndicator(
                                      color: Colors.white,
                                    ));

                                if (_validateEmptyField() &&
                                    validateEmail(emailController)) {
                                  // if validation success
                                  final result = await _authService.signIn(
                                    emailController.text,
                                    passwordController.text,
                                  );

                                  print("Log In: ${result.toString()}");

                                  if (result != null && result == false) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Could not sign in with credentials");
                                    setState(() =>
                                        _buttonChild = const Text("Log In"));
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          ),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: 'Don\'t have an account? ',
                                  style: TextStyle(color: CustomColor.neutral2),
                                ),
                                TextSpan(
                                  text: 'Sign Up',
                                  style:
                                      TextStyle(color: CustomColor.secondary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }

  bool _validateEmptyField() {
    return emailController.text.isEmpty || passwordController.text.isEmpty
        ? false
        : true;
  }
}
