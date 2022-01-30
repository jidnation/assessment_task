import 'package:assessment_task/app/modules/Auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/* ################################################################### */
/*    EXTRACTED WIDGETS    */

class Buttons extends StatelessWidget {
  final Widget child;
  final bool? haveBorder;
  final Color? fillColor;
  final Color? borderColor;
  final double? width;

  const Buttons({
    Key? key,
    required this.child,
    this.haveBorder,
    this.fillColor,
    this.borderColor,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1.5,
              color: (borderColor != null)
                  ? borderColor as Color
                  : Colors.transparent,
            )),
        child: child);
  }
}

class InputField extends StatelessWidget {
  final String hint;
  final bool? obscure;
  const InputField({
    Key? key,
    required this.hint,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (cont) {
          return TextFormField(
            keyboardType: TextInputType.text,
            scrollPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            cursorHeight: 18,
            cursorColor: Colors.grey,
            obscureText: (obscure != null) ? true : false,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              border: OutlineInputBorder(
                  gapPadding: 2, borderRadius: BorderRadius.circular(25)),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  gapPadding: 2,
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.grey.shade500,
                  )),
              hintStyle: const TextStyle(fontSize: 20),
            ),
            onChanged: (value) {
              if (hint == 'Email') {
                cont.email.value = value;
              } else {
                cont.password.value = value;
              }
            },
            validator: (hint == 'Email')
                ? cont.emailValidator
                : cont.passwordValidator,
          );
        });
  }
}
