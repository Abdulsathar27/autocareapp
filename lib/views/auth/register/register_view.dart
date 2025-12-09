import 'package:autocare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/helpers.dart';
import '../../../constants/app_colors.dart';
import '../../../contollers/user_auth_provider.dart';
import '../../../contollers/register_form_provider.dart';
import 'widgets/register/register_header.dart';
import 'widgets/register/name_field.dart';
import 'widgets/register/email_field.dart';
import 'widgets/register/phone_field.dart';
import 'widgets/register/password_field.dart';
import 'widgets/register/register_button.dart';
import 'widgets/register/login_footer.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  Future<void> handleRegister(BuildContext context) async {
    final form = context.read<RegisterFormProvider>();
    final authProvider = context.read<UserAuthProvider>();

    final name = form.nameCtrl.text.trim();
    final email = form.emailCtrl.text.trim();
    final phone = form.phoneCtrl.text.trim();
    final password = form.passCtrl.text.trim();

    // ----------- VALIDATION -----------
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      Helpers.showSnackBar(
        context,
        AppStrings.errorFillAllFields,
        backgroundColor: AppColors.redButton,
      );
      return;
    }
    if (password.length < 6) {
      Helpers.showSnackBar(
        context,
        AppStrings.errorPasswordTooShort,
        backgroundColor: AppColors.redButton,
      );
      return;
    }

    // ----------- CALL PROVIDER -----------
    final result = await authProvider.registerUser(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    if (!result.success) {
      Helpers.showSnackBar(
        context,
        result.error ?? AppStrings.errorRegistrationFailed,
        backgroundColor: AppColors.redButton,
      );
      return;
    }

    Helpers.showSnackBar(
      context,
      AppStrings.registrationSuccessful,
      backgroundColor: AppColors.primaryGreen,
    );

    Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final form = context.watch<RegisterFormProvider>();
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

              NameField(controller: form.nameCtrl),
              const SizedBox(height: 18),

              RegisterEmailField(controller: form.emailCtrl),
              const SizedBox(height: 18),

              PhoneField(controller: form.phoneCtrl),
              const SizedBox(height: 18),

              RegisterPasswordField(controller: form.passCtrl),
              const SizedBox(height: 25),

              RegisterButton(
                isLoading: authProvider.isEmailLoading,
                onPressed: authProvider.isEmailLoading
                    ? null
                    : () => handleRegister(context),
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
