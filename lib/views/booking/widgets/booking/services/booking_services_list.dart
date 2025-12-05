import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/contollers/booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'booking_service_tile.dart';

class BookingServicesList extends StatelessWidget {
  const BookingServicesList({super.key});

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();

    // SERVICE LIST WITH IDs
    final services = [
      {"id": "general_service", "name": "General Service", "icon": Icons.settings},
      {"id": "water_wash", "name": "Water Wash", "icon": Icons.water_drop},
      {"id": "full_detailing", "name": "Full Detailing", "icon": Icons.cleaning_services},
      {"id": "oil_change", "name": "Oil Change", "icon": Icons.oil_barrel},
      {"id": "tyre_change", "name": "Tyre Change", "icon": Icons.tire_repair},
      {"id": "ac_service", "name": "AC Service", "icon": Icons.ac_unit},
      {"id": "battery_check", "name": "Battery Check", "icon": Icons.battery_full},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final item = services[index];

        return BookingServiceTile(
          name: item["name"] as String,
          icon: item["icon"] as IconData,
          isSelected: booking.selectedServiceName == item["name"],
          onTap: () {
            // ❗ SAVE ID + NAME
            booking.selectService(
              item["id"] as String,
              item["name"] as String,
            );

            Navigator.pop(context);
          },
        );
      },
    );
  }
}
