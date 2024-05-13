// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowcut/Common/extensions.dart';
import 'package:wowcut/Utils/app_colors.dart';

class TextfieldCustom extends StatefulWidget {
  VoidCallback? onTap;
  TextInputType inputType;
  String hintText;
  bool obscure;
  FocusNode? focusNode = FocusNode();
  TextEditingController? controller = TextEditingController();
  final Function(PointerDownEvent)? onTapOutsidee;

  final ValueChanged? onChange;
  final String? Function(String?)? validator;
  Widget suffixIcon;
  bool readOnly;
  List<TextInputFormatter>? length;
  String initialValue;
  Widget? prefixIcon;

  TextfieldCustom({
    super.key,
    required this.hintText,
    this.obscure = false,
    required this.inputType,
    this.suffixIcon = const SizedBox(),
    this.focusNode,
    this.controller,
    this.validator,
    this.onChange,
    this.onTapOutsidee,
    this.readOnly = false,
    this.length,
    this.onTap,
    this.initialValue = "",
    this.prefixIcon,
  });

  @override
  State<TextfieldCustom> createState() => _TextfieldCustomState();
}

class _TextfieldCustomState extends State<TextfieldCustom> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // initialValue: widget.initialValue,
      onTap: widget.onTap,
      inputFormatters: widget.length,
      readOnly: widget.readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (event) {
        context.unFocus();
      },
      onChanged: widget.onChange,
      validator: widget.validator,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.obscure,
      keyboardType: widget.inputType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: const Color(0xff7f7f7f).withOpacity(0.5), width: 0.5),
        ),
        // fillColor: Colors.amber,
        focusColor: Colors.amber,
        contentPadding: const EdgeInsets.only(left: 20),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.inter(
          color: AppColors.lightGrey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textAlign: TextAlign.start,
    );
  }
}
