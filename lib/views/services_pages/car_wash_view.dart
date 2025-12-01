import 'package:flutter/material.dart';
import 'service_description_view.dart';

class CarWashView extends StatelessWidget {
  const CarWashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceDescriptionView(
      icon: Icons.local_car_wash,
      title: "Car Wash",
      description:
          "Premium interior and exterior wash using high-quality, "
          "scratch-free cleaning materials.",

      features: [
        "Foam wash",
        "Interior vacuum cleaning",
        "Dashboard polish",
        "Tyre & wheel cleaning",
        "Glass & mirror cleaning",
      ],
    );
  }
}
