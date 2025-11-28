import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/auth/register/register_header.dart';
import '../../widgets/auth/register/name_field.dart';
import '../../widgets/auth/register/email_field.dart';
import '../../widgets/auth/register/phone_field.dart';
import '../../widgets/auth/register/password_field.dart';
import '../../widgets/auth/register/register_button.dart';
import '../../widgets/auth/register/login_footer.dart';

import '../../controllers/auth_controller.dart';
import '../../providers/user_auth_provider.dart';
import '../../core/utils/helpers.dart';
import '../../constants/app_colors.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  final AuthController _authController = AuthController();

  bool isLoading = false;

  Future<void> _handleRegister() async {
    final name = nameCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final phone = phoneCtrl.text.trim();
    final password = passCtrl.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      Helpers.showSnackBar(context, "Please fill in all fields",
          backgroundColor: AppColors.redButton);
      return;
    }

    if (password.length < 6) {
      Helpers.showSnackBar(
        context,
        "Password must be at least 6 characters",
        backgroundColor: AppColors.redButton,
      );
      return;
    }

    final authProvider = Provider.of<UserAuthProvider>(context, listen: false);
    setState(() => isLoading = true);

    final result = await _authController.registerWithEmail(
      name: name,
      email: email,
      phone: phone,
      password: password,
      authProvider: authProvider,
    );

    if (!mounted) return;
    setState(() => isLoading = false);

    if (!result.success) {
      Helpers.showSnackBar(
        context,
        result.error ?? "Registration failed",
        backgroundColor: Colors.red,
      );
      return;
    }

    Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);

    Helpers.showSnackBar(
      context,
      "Account created successfully! Please login.",
      backgroundColor: AppColors.primaryGreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const RegisterHeader(),
              const SizedBox(height: 20),
              NameField(controller: nameCtrl),
              const SizedBox(height: 18),
              RegisterEmailField(controller: emailCtrl),
              const SizedBox(height: 18),
              PhoneField(controller: phoneCtrl),
              const SizedBox(height: 18),
              RegisterPasswordField(controller: passCtrl),
              const SizedBox(height: 25),
              RegisterButton(
                isLoading: isLoading,
                onPressed: _handleRegister,
              ),
              const SizedBox(height: 20),
              const LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
