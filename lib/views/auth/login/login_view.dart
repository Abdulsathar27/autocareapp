import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import '../../../contollers/user_auth_provider.dart';
import '../../../contollers/login_form_provider.dart';
import 'widgets/login/login_header.dart';
import 'widgets/login/email_field.dart';
import 'widgets/login/password_field.dart';
import 'widgets/login/forgot_password_button.dart';
import 'widgets/login/login_button.dart';
import 'widgets/login/google_button.dart';
import 'widgets/login/register_footer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  // EMAIL LOGIN HANDLER
  Future<void> handleLogin(BuildContext context) async {
    final form = context.read<LoginFormProvider>();
    final authProvider = context.read<UserAuthProvider>();
    final email = form.emailCtrl.text.trim();
    final password = form.passwordCtrl.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Helpers.showSnackBar(
        context,
        AppStrings.errorFillAllFields,
        backgroundColor: AppColors.redButton,
      );
      return;
    }

    final result = await authProvider.loginUser(
      email: email,
      password: password,
    );

    if (!result.success) {
      Helpers.showSnackBar(
        context,
        result.error ?? AppStrings.errorLoginFailed,
        backgroundColor: AppColors.redButton,
      );
      return;
    }
    Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
  }
  // GOOGLE LOGIN HANDLER
  Future<void> handleGoogleLogin(BuildContext context) async {
    final authProvider = context.read<UserAuthProvider>();
    final result = await authProvider.loginWithGoogle();
    if (!result.success) {
      Helpers.showSnackBar(
        context,
        result.error ?? AppStrings.errorGoogleSignInFailed,
        backgroundColor: AppColors.redButton,
      );
      return;
    }
    Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
  }
  @override
  Widget build(BuildContext context) {
    final form = context.watch<LoginFormProvider>();
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
              EmailField(controller: form.emailCtrl),
              const SizedBox(height: 18),
              PasswordField(controller: form.passwordCtrl),
              const ForgotPasswordButton(),
              // EMAIL LOGIN BUTTON
              LoginButton(
                isLoading: authProvider.isEmailLoading,
                onPressed: authProvider.isEmailLoading
                    ? null
                    : () => handleLogin(context),
              ),
              const SizedBox(height: 20),
              // GOOGLE LOGIN BUTTON
              GoogleSignInButton(
                isLoading: authProvider.isGoogleLoading,
                onPressed: authProvider.isGoogleLoading
                    ? null
                    : () => handleGoogleLogin(context),
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
