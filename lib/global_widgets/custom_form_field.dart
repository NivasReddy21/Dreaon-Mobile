import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatefulWidget {
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

  const CustomFormField({
    Key key,
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
  }) : super(key: key);
  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.4),
      ),
    );

    final underlineBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.4),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: widget.bottomPadding,
      ),
      child: TextFormField(
        validator: widget.validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(18),
          labelText: widget.labelText.toUpperCase(),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFFA8ADB7),
          ),
          prefixIcon: widget.prefixIcon != null ? widget.prefixIcon :  widget.icon != null
              ? Icon(
                  widget.icon,
                  color: Colors.grey.withOpacity(0.4),
                )
              : null,
          enabledBorder:
              widget.isOutlineBorder ? outlineBorder : underlineBorder,
          border: widget.isOutlineBorder ? outlineBorder : underlineBorder,
          suffixIcon: widget.isPasswordField
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
