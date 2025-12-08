import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';

class BookingStatusChip extends StatelessWidget {
  final String status;

  const BookingStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: const Text(
        AppStrings.confirmed,
        style: TextStyle(color: AppColors.background, fontWeight: FontWeight.w600),
      ),
      backgroundColor: AppColors.primaryGreen,
    );
  }
}
