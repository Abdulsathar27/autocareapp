import 'package:autocare/controller/register_form_provider.dart';
import 'package:autocare/controller/user_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/helpers.dart';
import '../../../constants/app_colors.dart';
import 'widgets/register/register_header.dart';
import 'widgets/register/name_field.dart';
import 'widgets/register/email_field.dart';
import 'widgets/register/phone_field.dart';
import 'widgets/register/password_field.dart';
import 'widgets/register/register_button.dart';
import 'widgets/register/login_footer.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.read<RegisterFormProvider>();
  
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

              Consumer2<UserAuthProvider,RegisterFormProvider>(
                builder: (context, authProvider,value, child) => RegisterButton(
                  isLoading: authProvider.isEmailLoading,
                  onPressed: authProvider.isEmailLoading
                      ? null
                      : () => authProvider.registerUser(
                            name: form.nameCtrl.text.trim(),
                            email: form.emailCtrl.text.trim(),
                            phone: form.phoneCtrl.text.trim(),
                            password: form.passCtrl.text.trim(),
                          ).then((result) {
                            if (result.success) {
                              value.clear();
                              Helpers.showSnackBar(
                                context,
                                "Registration success",
                                backgroundColor: Colors.green,
                              );
                              Navigator.pop(context);
                            } else {
                              Helpers.showSnackBar(
                                context,
                                "Registration failed: ${result.error}",
                                backgroundColor: Colors.red,
                              );
                            }
                          }
                ),
              ),
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
