import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../../../services/auth_controller.dart';
import '../../../contollers/user_auth_provider.dart';
import 'widgets/login/login_header.dart';
import 'widgets/login/email_field.dart';
import 'widgets/login/password_field.dart';
import 'widgets/login/forgot_password_button.dart';
import 'widgets/login/login_button.dart';
import 'widgets/login/google_button.dart';
import 'widgets/login/register_footer.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final AuthController _authController = AuthController();

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  // EMAIL LOGIN
  Future<void> _handleLogin() async {
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Helpers.showSnackBar(
        context,
        "Please fill in all fields",
        backgroundColor: AppColors.redButton,
      );
      return;
    }

    final authProvider = context.read<UserAuthProvider>();

    final result = await _authController.loginWithEmail(
      email: email,
      password: password,
      authProvider: authProvider,
    );

    if (result.success) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    } else {
      Helpers.showSnackBar(
        context,
        result.error ?? "Login failed",
        backgroundColor: AppColors.redButton,
      );
    }
  }

  // GOOGLE LOGIN
  Future<void> _handleGoogleLogin() async {
    final authProvider = context.read<UserAuthProvider>();

    final result = await _authController.loginWithGoogle(
      authProvider: authProvider,
    );

    if (result.success) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    } else {
      Helpers.showSnackBar(
        context,
        result.error ?? "Google sign-in failed",
        backgroundColor: AppColors.redButton,
      );
    }
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
              const LoginHeader(),
              const SizedBox(height: 25),
              EmailField(controller: emailCtrl),
              const SizedBox(height: 18),
              PasswordField(controller: passwordCtrl),
              const ForgotPasswordButton(),

              // EMAIL LOGIN BUTTON
              LoginButton(
                isLoading: authProvider.isEmailLoading,
                onPressed: _handleLogin,
              ),

              const SizedBox(height: 20),

              // GOOGLE LOGIN BUTTON
              GoogleSignInButton(
                isLoading: authProvider.isGoogleLoading,
                onPressed: _handleGoogleLogin,
              ),

              const SizedBox(height: 25),
              const RegisterFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
