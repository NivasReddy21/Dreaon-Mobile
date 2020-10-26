import '../global_widgets/custom_form_field.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class PhoneNoInput extends StatefulWidget {
  final String initialSelection;
  final ValueChanged<CountryCode> onChanged;

  final String labelText;
  final TextEditingController controller;
  final bool enabled;

  const PhoneNoInput({
    Key key,
    this.labelText,
    this.controller,
    this.enabled,
    this.initialSelection = "GH",
    @required this.onChanged,
  }) : super(key: key);

  @override
  _PhoneNoInputState createState() => _PhoneNoInputState();
}

class _PhoneNoInputState extends State<PhoneNoInput> {
  @override
  Widget build(BuildContext context) {
    final _countryCodePicker = CountryCodePicker(
      initialSelection: "US",
      favorite: ['US', 'GH'],
      showCountryOnly: true,
      showOnlyCountryWhenClosed: false,
      alignLeft: true,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      onChanged: (CountryCode countryCode) {
        setState(() {
          widget.onChanged(countryCode);
        });
      },
    );

    final _inputField = CustomFormField(
      labelText: widget.labelText,
      keyboardType: TextInputType.number,
      controller: widget.controller,
      prefixIcon: SizedBox(
        width: 110.0,
        child: _countryCodePicker,
      ),
    );

    return _inputField;

    // return Container(
    //   child: Row(
    //     children: <Widget>[
    //       Expanded(
    //         child: _countryCodePicker,
    //       ),
    //       Expanded(
    //         child: _inputField,
    //         flex: 2,
    //       )
    //     ],
    //   ),
    // );
  }
}
