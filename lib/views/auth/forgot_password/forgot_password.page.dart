import 'package:buddy/services/authentication.service.dart';

import '../../../services/alert.service.dart';

import '../../../constants/images.dart';
import '../../../utils/utils.dart';
import '../../../global_widgets/auth_base_view.dart';
import '../../../global_widgets/custom_button.dart';
import '../../../global_widgets/custom_form_field.dart';
import '../../../global_widgets/header_text.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import '../../../config/extensions.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController email = new TextEditingController();
  AlertService alert = new AlertService();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Image.asset(
        AppImages.password,
      ).bounce(),
    ).fadeIn(1);

    final title = HeaderText(text: "Password Recovery").fadeIn(2);
    final subtitle = HeaderText(
      text: "Enter your email to recover your password",
      isBig: false,
    ).fadeIn(2.4);

    final emailField = CustomFormField(
      labelText: "Email Address",
      icon: LineAwesomeIcons.envelope,
      controller: email,
    );

    final button = CustomButton(
      text: "Send Email",
      onPressed: () async {
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
        } else {
          await Authentication().resetPassword(email.text);
          alert.show(
            context: context,
            message: "Instructions have been sent to your email",
            type: AlertType.success,
          );
          email.clear();
        }
      },
      isGradient: true,
    );

    final form = Form(
      child: Column(
        children: <Widget>[
          Utils.verticalSpacer(space: 20.0),
          emailField,
          button,
        ],
      ),
    ).fadeIn(3);

    return AuthBaseView(
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
