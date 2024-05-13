import 'package:flutter/material.dart';
import 'package:wowcut/Utils/app_colors.dart';

class CustomCheckbox1 extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  bool flag;

  CustomCheckbox1(
      {Key? key,
      required this.isSelected,
      required this.onTap,
      this.flag = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(50.0),
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
        ),
        child: isSelected
            ? const Icon(
                Icons.check,
                size: 14.0,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
