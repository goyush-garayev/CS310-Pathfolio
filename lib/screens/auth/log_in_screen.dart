import 'package:flutter/material.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/validators.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/common.dart';
import 'social_buttons.dart';

/// Log in form. UI only in Step 2.
class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveBody(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopNav(),
                  const Gap(AppSpacing.md),
                  const ScreenHeader(
                    title: 'Welcome back',
                    subtitle: 'Log in to see your saved trips.',
                  ),
                  const Gap(AppSpacing.xl),
                  AppTextField(
                    label: 'Email',
                    hint: 'name@sabanciuniv.edu',
                    controller: _email,
                    validator: Validators.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const Gap(AppSpacing.lg),
                  AppTextField(
                    label: 'Password',
                    controller: _password,
                    validator: Validators.password,
                    obscureText: _hidePassword,
                    suffixIcon: IconButton(
                      icon: Icon(_hidePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: () =>
                          setState(() => _hidePassword = !_hidePassword),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Password reset will be added in Step 3')),
                      ),
                      child: const Text('Forgot password?',
                          style: AppTextStyles.link),
                    ),
                  ),
                  const Gap(AppSpacing.sm),
                  PrimaryButton(label: 'Log in', onPressed: _submit),
                  const Gap(AppSpacing.lg),
                  const OrDivider(),
                  const Gap(AppSpacing.lg),
                  const SocialButtons(),
                  const Gap(AppSpacing.xl),
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('New to PathFolio? ',
                            style: AppTextStyles.bodyMuted),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, AppRoutes.signUp),
                          child: const Text('Sign up',
                              style: AppTextStyles.link),
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.lg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
