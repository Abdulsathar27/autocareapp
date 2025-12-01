import 'package:flutter/material.dart';
import 'service_description_view.dart';

class GeneralServiceView extends StatelessWidget {
  const GeneralServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceDescriptionView(
      icon: Icons.car_repair,
      title: "General Service",
      description:
          "General servicing keeps your vehicle smooth, efficient, and safe. "
          "Technicians inspect and replace essential components.",

      features: [
        "Engine oil change",
        "Brake inspection",
        "Battery health check",
        "Coolant top-up",
        "Full vehicle health scan",
      ],
    );
  }
}
