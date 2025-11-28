import 'package:flutter/material.dart';
import '../../../constants/app_assets.dart';

class BookingSummaryHeader extends StatelessWidget {
  const BookingSummaryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Image.asset(AppAssets.bookingConfirmation, fit: BoxFit.contain),
    );
  }
}
