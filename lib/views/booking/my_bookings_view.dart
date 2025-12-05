import 'package:autocare/views/booking/widgets/booking/my_bookings/booking_empty_state.dart';
import 'package:autocare/views/booking/widgets/booking/my_bookings/booking_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_sizes.dart';
import '../../../contollers/user_provider.dart';
import '../../../contollers/booking_provider.dart';
import '../../../models/booking_model.dart';


class MyBookingsView extends StatelessWidget {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserProvider>().userId;

    if (userId == null || userId.isEmpty) {
      return const BookingEmptyState();
    }

    final bookingProvider = context.watch<BookingProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("My Bookings"),
        centerTitle: true,
        backgroundColor: AppColors.background,
      ),
      body: StreamBuilder<List<BookingModel>>(
        stream: bookingProvider.userBookingStream(userId),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final bookings = snap.data!;

          if (bookings.isEmpty) {
            return const BookingEmptyState();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSizes.paddingMD),
            itemCount: bookings.length,
            itemBuilder: (context, i) {
              return BookingItemCard(model: bookings[i]);
            },
          );
        },
      ),
    );
  }
}
