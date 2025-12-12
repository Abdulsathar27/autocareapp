import 'package:autocare/controller/home_nav_provider.dart';
import 'package:autocare/controller/login_form_provider.dart';
import 'package:autocare/controller/user_auth_provider.dart';
import 'package:autocare/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';
import '../../../core/utils/helpers.dart';
import 'widgets/login/login_header.dart';
import 'widgets/login/email_field.dart';
import 'widgets/login/password_field.dart';
import 'widgets/login/forgot_password_button.dart';
import 'widgets/login/login_button.dart';
import 'widgets/login/google_button.dart';
import 'widgets/login/register_footer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});


  @override
  Widget build(BuildContext context) {
    final form = context.read<LoginFormProvider>();
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
              Consumer3<UserAuthProvider,HomeNavProvider,LoginFormProvider>(
                builder: (context, authProvider,value2,value3, homeNavProvider) => LoginButton(
                  isLoading: authProvider.isEmailLoading,
                  onPressed: authProvider.isEmailLoading
                      ? null
                      : () => authProvider.loginUser(email: form.emailCtrl.text.trim(), password: form.passwordCtrl.text.trim()).then((result) {
                            if (result.success) {
                              value2.setIndex(0);
                              value3.clear();
                              Helpers.showSnackBar(context,
                                "Login success",
                                backgroundColor: Colors.green,);
                                Navigator.pushReplacementNamed(context, AppRoutes.home);
                            } else {
                              Helpers.showSnackBar(
                                context,
                                "Login failed: ${result.error}",
                                backgroundColor: Colors.red,
                              );
                            }
                          }
                ),
              ),
              ),
              const SizedBox(height: 20),
              // GOOGLE LOGIN BUTTON
              Consumer2<UserAuthProvider,HomeNavProvider>(
                builder: (context, authProvider,value, child) => GoogleSignInButton(
                  isLoading: authProvider.isGoogleLoading,
                  onPressed: authProvider.isGoogleLoading
                      ? null
                      : () => authProvider.loginWithGoogle().then((result) {
                            if (result.success) {
                              value.setIndex(0);
                              Helpers.showSnackBar(context,
                                "Google login success",
                                backgroundColor: Colors.green,);
                                Navigator.pushReplacementNamed(context, AppRoutes.home);
                            } else {
                              Helpers.showSnackBar(
                                context,
                                "Google login failed: ${result.error}",
                                backgroundColor: Colors.red,
                              );
                            }
                          }
                ),
              ),
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
