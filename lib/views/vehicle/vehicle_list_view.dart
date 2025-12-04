import 'package:autocare/views/vehicle/widgets/vehicle/vehicle_list_appbar.dart';
import 'package:autocare/views/vehicle/widgets/vehicle/vehicle_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../contollers/user_auth_provider.dart';

class VehicleListView extends StatelessWidget {
  const VehicleListView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId =
        Provider.of<UserAuthProvider>(context, listen: false).currentUserId;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const VehicleListAppBar(),
      body: VehicleStreamBuilder(userId: userId),
    );
  }
}
