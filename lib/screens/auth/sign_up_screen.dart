import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/validators.dart';
import '../../widgets/app_buttons.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/common.dart';
import 'social_buttons.dart';

/// Sign up form. UI only in Step 2 (no real account is created).
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hidePassword = true;
  bool _acceptedTerms = false;
  bool _showTermsError = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    final valid = _formKey.currentState!.validate();
    setState(() => _showTermsError = !_acceptedTerms);
    if (!valid || !_acceptedTerms) return;
    // Authentication comes in Step 3. For now go straight to Home.
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
                    title: 'Create account',
                    subtitle: 'Save your trips and preferences.',
                  ),
                  const Gap(AppSpacing.xl),
                  AppTextField(
                    label: 'Full name',
                    hint: 'Goyush Garayev',
                    controller: _name,
                    validator: Validators.name,
                    textInputAction: TextInputAction.next,
                  ),
                  const Gap(AppSpacing.lg),
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
                    hint: 'At least 6 characters',
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
                  const Gap(AppSpacing.md),
                  // Terms checkbox
                  InkWell(
                    onTap: () => setState(() {
                      _acceptedTerms = !_acceptedTerms;
                      if (_acceptedTerms) _showTermsError = false;
                    }),
                    child: Row(
                      children: [
                        Checkbox(
                          value: _acceptedTerms,
                          activeColor: AppColors.primary,
                          visualDensity: VisualDensity.compact,
                          onChanged: (v) => setState(() {
                            _acceptedTerms = v ?? false;
                            if (_acceptedTerms) _showTermsError = false;
                          }),
                        ),
                        const Expanded(
                          child: Text('I agree to the Terms and Privacy Policy',
                              style: AppTextStyles.bodyMuted),
                        ),
                      ],
                    ),
                  ),
                  if (_showTermsError)
                    Padding(
                      padding: const EdgeInsets.only(left: AppSpacing.md),
                      child: Text('Please accept the terms',
                          style: AppTextStyles.small
                              .copyWith(color: AppColors.error)),
                    ),
                  const Gap(AppSpacing.lg),
                  PrimaryButton(label: 'Create account', onPressed: _submit),
                  const Gap(AppSpacing.lg),
                  const OrDivider(),
                  const Gap(AppSpacing.lg),
                  const SocialButtons(),
                  const Gap(AppSpacing.lg),
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('Already have an account? ',
                            style: AppTextStyles.bodyMuted),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, AppRoutes.logIn),
                          child:
                              const Text('Log in', style: AppTextStyles.link),
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
