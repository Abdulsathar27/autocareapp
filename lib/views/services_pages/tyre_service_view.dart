import 'package:flutter/material.dart';
import 'service_description_view.dart';

class TyreServiceView extends StatelessWidget {
  const TyreServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceDescriptionView(
      icon: Icons.tire_repair,
      title: "Tyre Service",
      description:
          "Complete tyre maintenance including replacement, balancing, "
          "alignment, and puncture repair.",

      features: [
        "Tyre rotation",
        "Wheel alignment",
        "Puncture repair",
        "Tyre balancing",
        "Air pressure check",
      ],
    );
  }
}
