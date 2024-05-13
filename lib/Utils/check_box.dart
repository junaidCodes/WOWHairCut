import 'package:flutter/material.dart';
import 'package:wowcut/Utils/app_colors.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomCheckbox({
    Key? key,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _value = !_value;
          widget.onChanged?.call(_value);
        });
      },
      child: Container(
        width: 16.0,
        height: 16.0,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(5.0),
          color: _value ? AppColors.primaryColor : Colors.white,
        ),
        child: _value
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
