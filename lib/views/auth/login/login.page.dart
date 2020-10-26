import 'package:buddy/services/authentication.service.dart';

import '../../../services/alert.service.dart';

import '../../../constants/routes.dart';

import '../../../constants/images.dart';
import '../../../utils/utils.dart';
import '../../../global_widgets/auth_base_view.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_form_field.dart';
import '../../../global_widgets/header_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import '../../../config/extensions.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  AlertService alert = new AlertService();

  bool isBusy = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Image.asset(
        AppImages.social,
      ).bounce(),
    ).fadeIn(0.75);

    final title = HeaderText(text: "Welcome Back!").fadeIn(2);
    final subtitle = HeaderText(
      text: "Login to your account",
      isBig: false,
    ).fadeIn(1.5);

    final emailField = CustomFormField(
      labelText: "Email Address",
      icon: LineAwesomeIcons.envelope,
      controller: email,
    );

    final passwordField = CustomFormField(
      labelText: "Password",
      icon: LineAwesomeIcons.lock,
      isPasswordField: true,
      controller: password,
    );

    final forgotPassword = Container(
      margin: EdgeInsets.only(bottom: 10.0),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    final newUser = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Don't have an account? ",
          style: Theme.of(context).textTheme.bodyText1,
          children: <TextSpan>[
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed(AppRoutes.register);
                },
            ),
          ],
        ),
      ),
    );

    final button = CustomButton(
      text: "LOGIN",
      onPressed: () {
        if (email.text.isEmpty) {
          alert.show(
            context: context,
            message: "Email is required!",
            type: AlertType.error,
          );
        } else if (!email.text.contains('@')) {
          alert.show(
            context: context,
            message: "Email is invalid",
            type: AlertType.error,
          );
        } else if (password.text.isEmpty) {
          alert.show(
            context: context,
            message: "Password is required!",
            type: AlertType.error,
          );
        } else {
          setState(() {
            isBusy = true;
          });
          Authentication().login(
            context: context,
            email: email.text,
            password: password.text,
          );
          setState(() {
            isBusy = false;
          });
        }
      },
      isGradient: true,
    );

    final form = Form(
      child: Column(
        children: <Widget>[
          Utils.verticalSpacer(space: 20.0),
          emailField,
          passwordField,
          forgotPassword,
          button,
          newUser
          // privacyPolicy
        ],
      ),
    ).fadeIn(0.75);

    return isBusy
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : AuthBaseView(
            body: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 0.0,
                bottom: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [image, title, subtitle, form],
              ),
            ),
          );
  }
}
