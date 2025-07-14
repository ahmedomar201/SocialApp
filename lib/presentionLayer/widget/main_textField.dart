import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool isPassword;
  final bool isValidate;
  final String? validationError;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final GestureTapCallback? onTap;
  final bool enabled;
  final double? height;
  final double? width;
  final List<TextInputFormatter>? inputFormatters;

  const MainTextField({
    super.key,
    required this.controller,
    this.label,
    this.isPassword = false,
    this.isValidate = true,
    this.validationError,
    this.enabled = true,
    this.onTap,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.height,
    this.width,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: width ?? MediaQuery.of(context).size.width * .25,
      // height: height ?? 80,
      child: TextFormField(
        readOnly: false,
           decoration: InputDecoration(
                          labelText: "email address",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
        keyboardType: keyboardType,
        obscureText: isPassword,
        controller: controller,
        enabled: enabled,
        onTap: onTap,
        validator: isValidate
            ? (value) {
                if (value!.isEmpty) {
                  return validationError ?? "Required";
                }
                return null;
              }
            : null,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
