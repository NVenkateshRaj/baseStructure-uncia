import 'package:flutter/material.dart';
import 'package:network_issue_handle/constants/styles.dart';


class CustomRadioButton extends StatelessWidget {
  final String labelText;
  final List<String> options;
  final String initialSelection;
  final Function(String)? onSelectionChanged;

  const CustomRadioButton({
    super.key,
    required this.labelText,
    required this.options,
    required this.initialSelection,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppTextStyle.bodyRegular,
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: options.map((option) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                  value: option,
                  groupValue: initialSelection,
                  onChanged: onSelectionChanged!=null ?  (String? val) => onSelectionChanged!.call(val!) : null ,
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

