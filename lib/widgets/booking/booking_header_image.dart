import 'package:flutter/material.dart';
import '../../constants/app_assets.dart';

class BookingHeaderImage extends StatelessWidget {
  const BookingHeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        child: Image.asset(AppAssets.bookingScreen, fit: BoxFit.contain),
      ),
    );
  }
}
