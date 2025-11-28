import 'package:autocare/constants/app_colors.dart';
import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/constants/firebase_keys.dart';
import 'package:autocare/providers/user_provider.dart';
import 'package:autocare/widgets/booking/my_bookings/booking_empty_state.dart';
import 'package:autocare/widgets/booking/my_bookings/booking_item_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBookingsView extends StatelessWidget {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.userId;

    // FIX: userId is empty string when no user — not null
    if (userId!.isEmpty) {
      return const BookingEmptyState();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0.3,
        centerTitle: true,
        title: const Text("My Bookings"),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(FirebaseKeys.bookings)
            .where(FirebaseKeys.userId, isEqualTo: userId)
            .orderBy(FirebaseKeys.createdAt, descending: true)
            .snapshots(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snap.hasData || snap.data!.docs.isEmpty) {
            return const BookingEmptyState();
          }

          final docs = snap.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(AppSizes.paddingMD),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return BookingItemCard(
                data: docs[index].data() as Map<String, dynamic>,
                bookingId: docs[index].id,
              );
            },
          );
        },
      ),
    );
  }
}
