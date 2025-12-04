import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/login/login_header.dart';
import 'widgets/login/email_field.dart';
import 'widgets/login/password_field.dart';
import 'widgets/login/forgot_password_button.dart';
import 'widgets/login/login_button.dart';
import 'widgets/login/google_button.dart';
import 'widgets/login/register_footer.dart';
import '../../../services/auth_controller.dart';
import '../../../contollers/user_auth_provider.dart';
import '../../../core/utils/helpers.dart';
import '../../../constants/app_colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}
class _LoginViewState extends State<LoginView> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final AuthController _authController = AuthController();
  bool isLoading = false;
  bool isGoogleLoading = false;
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
    final authProvider = Provider.of<UserAuthProvider>(context, listen: false);
    setState(() => isLoading = true);
    final result = await _authController.loginWithEmail(
      email: email,
      password: password,
      authProvider: authProvider,
    );
    if (!mounted) return;
    setState(() => isLoading = false);
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
  Future<void> _handleGoogleLogin() async {
    final authProvider = Provider.of<UserAuthProvider>(context, listen: false);
    setState(() => isGoogleLoading = true);
    final result = await _authController.loginWithGoogle(
      authProvider: authProvider,
    );
    if (!mounted) return;
    setState(() => isGoogleLoading = false);
    if (result.success) {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
    } else {
      Helpers.showSnackBar(
        context,
        result.error ?? "Google login failed",
        backgroundColor: AppColors.redButton,
      );
    }
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
              const LoginHeader(),
              const SizedBox(height: 25),
              EmailField(controller: emailCtrl),
              const SizedBox(height: 18),
              PasswordField(controller: passwordCtrl),
              const ForgotPasswordButton(),
              LoginButton(isLoading: isLoading, onPressed: _handleLogin),
              const SizedBox(height: 20),
              GoogleSignInButton(
                isLoading: isGoogleLoading,
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
