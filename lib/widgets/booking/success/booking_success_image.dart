import 'package:flutter/material.dart';
import '../../../constants/app_assets.dart';

class BookingSuccessImage extends StatelessWidget {
  const BookingSuccessImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Image.asset(
        AppAssets.bookingSuccess,
        fit: BoxFit.contain,
      ),
    );
  }
}
