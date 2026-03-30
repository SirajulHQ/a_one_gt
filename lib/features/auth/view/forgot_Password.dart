import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/core/utils/dimensions.dart';
import 'package:a_one_gt/features/auth/widgets/forgot_password_widgets.dart';
import 'package:a_one_gt/features/category/view/Categories_page.dart'
    show CategoriesPage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';

enum _Step { email, otp, newPassword }

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureNew = true;
  bool _obscureConfirm = true;
  _Step _step = _Step.email;

  // Validation error states
  String? _emailError;
  String? _otpError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  void _sendOtp() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _emailError = "Please enter your email address");
      return;
    }
    setState(() => _emailError = null);
    HapticFeedback.lightImpact();
    setState(() => _step = _Step.otp);
    _showToast("OTP sent to $email");
  }

  void _verifyOtp() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      setState(() => _otpError = "Please enter the complete 6-digit OTP");
      return;
    }
    setState(() => _otpError = null);
    HapticFeedback.lightImpact();
    setState(() => _step = _Step.newPassword);
    _showToast("OTP verified successfully");
  }

  void _resetPassword() {
    final newPass = _newPasswordController.text;
    final confirmPass = _confirmPasswordController.text;
    bool hasError = false;

    if (newPass.isEmpty) {
      setState(() => _newPasswordError = "Please enter a new password");
      hasError = true;
    } else {
      setState(() => _newPasswordError = null);
    }

    if (confirmPass.isEmpty) {
      setState(() => _confirmPasswordError = "Please confirm your password");
      hasError = true;
    } else if (newPass != confirmPass) {
      setState(() => _confirmPasswordError = "Passwords do not match");
      hasError = true;
    } else {
      setState(() => _confirmPasswordError = null);
    }

    if (hasError) return;

    HapticFeedback.lightImpact();
    _showToast("Password reset successfully");
    // TODO: submit new password to backend here
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CategoriesPage()),
        (route) => false,
      );
    });
  }

  void _showToast(String message) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
      showProgressBar: false,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    for (final c in _otpControllers) c.dispose();
    for (final f in _otpFocusNodes) f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20 * 1.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.height20),

              /// Back Button
              Container(
                height: Dimensions.height45,
                width: Dimensions.height45,
                decoration: const BoxDecoration(
                  color: Color(0xffEDEDED),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    if (_step == _Step.otp) {
                      setState(() {
                        _step = _Step.email;
                        _otpError = null;
                        for (final c in _otpControllers) c.clear();
                      });
                    } else if (_step == _Step.newPassword) {
                      setState(() {
                        _step = _Step.otp;
                        _newPasswordError = null;
                        _confirmPasswordError = null;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
              ),

              SizedBox(height: Dimensions.height45),

              /// Title
              Text(
                _step == _Step.email
                    ? "Forgot Password"
                    : _step == _Step.otp
                    ? "Enter OTP"
                    : "New Password",
                style: TextStyle(
                  fontSize: Dimensions.font26 + 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: Dimensions.height20 * 0.5),

              Text(
                _step == _Step.email
                    ? "Enter your email to receive an OTP"
                    : _step == _Step.otp
                    ? "We sent a 6-digit code to ${_emailController.text.trim()}"
                    : "Set a new password for your account",
                style: TextStyle(
                  fontSize: Dimensions.font16 - 1,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: Dimensions.height30),

              /// Step content
              if (_step == _Step.email)
                EmailFieldWidget(
                  controller: _emailController,
                  error: _emailError,
                  onChanged: (_) {
                    if (_emailError != null) {
                      setState(() => _emailError = null);
                    }
                  },
                ),

              if (_step == _Step.otp)
                OtpFieldsWidget(
                  controllers: _otpControllers,
                  focusNodes: _otpFocusNodes,
                  error: _otpError,
                  onChanged: (index, value) {
                    if (_otpError != null) setState(() => _otpError = null);

                    if (value.isNotEmpty && index < 5) {
                      _otpFocusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      _otpFocusNodes[index - 1].requestFocus();
                    }
                  },
                ),

              if (_step == _Step.newPassword)
                Column(
                  children: [
                    PasswordFieldWidget(
                      controller: _newPasswordController,
                      hint: "New Password",
                      obscure: _obscureNew,
                      error: _newPasswordError,
                      onToggle: () =>
                          setState(() => _obscureNew = !_obscureNew),
                      onChanged: (_) {
                        if (_newPasswordError != null) {
                          setState(() => _newPasswordError = null);
                        }
                      },
                    ),
                    SizedBox(height: Dimensions.height20),
                    PasswordFieldWidget(
                      controller: _confirmPasswordController,
                      hint: "Confirm Password",
                      obscure: _obscureConfirm,
                      error: _confirmPasswordError,
                      onToggle: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                      onChanged: (_) {
                        if (_confirmPasswordError != null) {
                          setState(() => _confirmPasswordError = null);
                        }
                      },
                    ),
                  ],
                ),

              SizedBox(height: Dimensions.height30),

              /// Primary Button
              SizedBox(
                width: double.infinity,
                height: Dimensions.height45 + 5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.primaryGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _step == _Step.email
                      ? _sendOtp
                      : _step == _Step.otp
                      ? _verifyOtp
                      : _resetPassword,
                  child: Text(
                    _step == _Step.email
                        ? "Send OTP"
                        : _step == _Step.otp
                        ? "Verify OTP"
                        : "Reset Password",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              if (_step == _Step.otp) ...[
                SizedBox(height: Dimensions.height20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _step = _Step.email;
                        _otpError = null;
                        for (final c in _otpControllers) c.clear();
                      });
                    },
                    child: Text(
                      "Change email?",
                      style: TextStyle(
                        color: Appcolors.primaryGreen,
                        fontSize: Dimensions.font16 - 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
