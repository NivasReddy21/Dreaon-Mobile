import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormFieldAlt extends StatefulWidget {
  final String hintText;
  final String labelText;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final TextEditingController controller;
  final bool enabled;
  final double height;
  final int maxLines;
  final Function onTap;
  final bool readOnly;
  final bool isOutlineBorder;
  final List<TextInputFormatter> inputFormatters;
  final String Function(String) validator;
  final Function(String) onChanged;
  final double bottomPadding;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final FocusNode focusNode;

  const CustomFormFieldAlt({
    Key key,
    this.hintText,
    this.labelText,
    this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPasswordField = false,
    this.controller,
    this.enabled = true,
    this.height,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.isOutlineBorder = true,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.bottomPadding = 20.0,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
  }) : super(key: key);

  @override
  _CustomFormFieldAltState createState() => _CustomFormFieldAltState();
}

class _CustomFormFieldAltState extends State<CustomFormFieldAlt> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.4),
      ),
    );

    final focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.4),
        width: 2
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: widget.bottomPadding,
      ),
      child: TextFormField(
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFFA8ADB7),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: widget.prefixIcon != null
              ? widget.prefixIcon
              : widget.icon != null
                  ? Icon(
                      widget.icon,
                      color: Theme.of(context).primaryColor,
                      size: 26,
                    )
                  : null,
          filled: true,
          enabledBorder: outlineBorder,
          focusedBorder: focusBorder,
          border: outlineBorder,
          suffixIcon: widget.suffixIcon != null ? widget.suffixIcon : widget.isPasswordField
              ? _buildPasswordFieldVisibilityToggle()
              : null,
        ),
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        keyboardType: widget.keyboardType,
        cursorColor: Theme.of(context).primaryColor,
        obscureText: widget.isPasswordField ? _obscureText : false,
        controller: widget.controller,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        onTap: widget.onTap ?? null,
        readOnly: widget.readOnly,
        inputFormatters: widget.inputFormatters ?? null,
        onChanged: widget.onChanged,
        focusNode: widget.focusNode,
      ),
    );
  }

  Widget _buildPasswordFieldVisibilityToggle() {
    return IconButton(
      icon: Icon(
        _obscureText ? Icons.visibility_off : Icons.visibility,
        color: Colors.grey,
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}
