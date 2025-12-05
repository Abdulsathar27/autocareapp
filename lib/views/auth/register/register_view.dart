import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../services/auth_controller.dart';
import '../../../contollers/user_auth_provider.dart';
import '../../../core/utils/helpers.dart';
import '../../../constants/app_colors.dart';
import 'widgets/register/register_header.dart';
import 'widgets/register/name_field.dart';
import 'widgets/register/email_field.dart';
import 'widgets/register/phone_field.dart';
import 'widgets/register/password_field.dart';
import 'widgets/register/register_button.dart';
import 'widgets/register/login_footer.dart';

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

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  Future<void> handleRegister() async {
    final name = nameCtrl.text.trim();
    final email = emailCtrl.text.trim();
    final phone = phoneCtrl.text.trim();
    final password = passCtrl.text.trim();

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      Helpers.showSnackBar(
        context,
        "Please fill in all fields",
        backgroundColor: AppColors.redButton,
      );
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

    final authProvider = context.read<UserAuthProvider>();

    final result = await _authController.registerWithEmail(
      name: name,
      email: email,
      phone: phone,
      password: password,
      authProvider: authProvider,
    );

    if (!result.success) {
      Helpers.showSnackBar(
        context,
        result.error ?? "Registration failed",
        backgroundColor: AppColors.redButton,
      );
      return;
    }

    // SUCCESS
    Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
    Helpers.showSnackBar(
      context,
      "Account created successfully! Please login.",
      backgroundColor: AppColors.primaryGreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<UserAuthProvider>();

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

              // NOW USING PROVIDER LOADING
              RegisterButton(
                isLoading: authProvider.isEmailLoading,
                onPressed: authProvider.isEmailLoading ? () {} : handleRegister,
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
