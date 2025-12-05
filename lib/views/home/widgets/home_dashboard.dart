import 'package:autocare/constants/app_sizes.dart';
import 'package:autocare/views/home/widgets/home_header.dart';
import 'package:autocare/views/home/widgets/search_bar.dart';
import 'package:autocare/views/home/widgets/services_section.dart';
import 'package:flutter/material.dart';

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingMD),
      child: Column(
        children: const [
          SizedBox(height: AppSizes.paddingXL),
          HomeHeader(),
          SizedBox(height: AppSizes.paddingXL),
          HomeSearchBar(),
          SizedBox(height: AppSizes.paddingXL),
          ServicesSection(),
        ],
      ),
    );
  }
}