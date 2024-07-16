import 'package:client/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  final String label;
  final String value;
  final bool isFirst;
  final bool isLast;

  const ProfileContainer({
    required this.label,
    required this.value,
    this.isFirst = false,
    this.isLast = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 50,
      decoration: BoxDecoration(
        color: Pallete.containerColor,
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(
                  color: Pallete.borderLineColor,
                  width: 0.5,
                ),
        ),
        borderRadius: calculateBorderRadius(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Pallete.greyColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius calculateBorderRadius() {
    if (isFirst && isLast) {
      return BorderRadius.circular(15);
    } else if (isFirst) {
      return const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      );
    } else if (isLast) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      );
    } else {
      return BorderRadius.zero;
    }
  }
}
