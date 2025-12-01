import 'package:flutter/material.dart';
import 'service_description_view.dart';

class RepairWorkView extends StatelessWidget {
  const RepairWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ServiceDescriptionView(
      icon: Icons.build_circle,
      title: "Repair Work",
      description:
          "Professional mechanical repair for engine, clutch, suspension, "
          "and electrical systems ensuring restored performance.",

      features: [
        "Engine diagnostics",
        "Electrical troubleshooting",
        "Suspension repairs",
        "Clutch & gearbox work",
        "Component replacement",
      ],
    );
  }
}
