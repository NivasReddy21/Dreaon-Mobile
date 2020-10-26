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

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  AlertService alert = new AlertService();
  bool isBusy = false;

  @override
  void dispose() {
    email.dispose();
    name.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Image.asset(
        AppImages.social2,
      ).bounce(),
    ).fadeIn(1);

    final title = HeaderText(text: "Hello!").fadeIn(2);
    final subtitle = HeaderText(
      text: "Create an account to continue",
      isBig: false,
    ).fadeIn(2.4);

    final nameField = CustomFormField(
      labelText: "Full Name",
      icon: LineAwesomeIcons.user,
      controller: name,
    );

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

    final oldUser = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Already have an account? ",
          style: Theme.of(context).textTheme.bodyText1,
          children: <TextSpan>[
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                },
            ),
          ],
        ),
      ),
    );

    final button = CustomButton(
      text: "SIGN UP",
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
        } else if (name.text.isEmpty) {
          alert.show(
            context: context,
            message: "Name is required!",
            type: AlertType.error,
          );
        } else if (password.text.isEmpty) {
          alert.show(
            context: context,
            message: "Password is required!",
            type: AlertType.error,
          );
        } else if (password.text.length < 6) {
          alert.show(
            context: context,
            message: "Password must have 6 or more characters",
            type: AlertType.error,
          );
        } else {
          setState(() {
            isBusy = true;
          });
          Authentication().register(
              userName: name.text,
              email: email.text,
              password: password.text,
              context: context);
        }
      },
      isGradient: true,
    );

    final form = Form(
      child: Column(
        children: <Widget>[
          Utils.verticalSpacer(space: 20.0),
          nameField,
          emailField,
          passwordField,
          button,
          oldUser
          // privacyPolicy
        ],
      ),
    ).fadeIn(0.75);

    return isBusy
        ? Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'An Verification Email Has Been Sent to You,\n Please Verify Your Email And Login',
                    ),
                  ],
                ),
              ),
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
