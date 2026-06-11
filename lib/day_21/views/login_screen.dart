import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ppkd_b6/constant/app_color.dart';
import 'package:ppkd_b6/constant/app_image.dart';
import 'package:ppkd_b6/day_20/database/db_helper.dart';
import 'package:ppkd_b6/day_20/models/user_model_sql.dart';
import 'package:ppkd_b6/day_20/views/home_screen.dart';
import 'package:ppkd_b6/day_20/views/register_screen.dart';
import 'package:ppkd_b6/extension/navigator.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreenDay21 extends StatefulWidget {
  const LoginScreenDay21({super.key});

  @override
  State<LoginScreenDay21> createState() => _LoginScreenDay21State();
}

class _LoginScreenDay21State extends State<LoginScreenDay21> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    final email = emailController.text.trim();
    final pass = passwordController.text;

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Isi semua field!')));
      return;
    }

    final pengguna = await DBHelper().loginUser(
      UserModelSql(email: email, password: pass),
    );

    if (!mounted) return;

    if (pengguna != null) {
      context.pushAndRemoveAll(const HomeScreenDay20());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal! email atau Password salah.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.gradientColor1.withOpacity(0.05),
              AppColor.gradientColor3.withOpacity(0.15),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo and Title
                    Image.asset(AppImage.logo, height: 80),
                    const SizedBox(height: 32),
                    
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: GradientText(
                              'Welcome Back',
                              style: const TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                              colors: [
                                AppColor.gradientColor1,
                                AppColor.gradientColor2,
                                AppColor.gradientColor3,
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              "Login to continue exploring",
                              style: TextStyle(color: AppColor.greyColorOr, fontSize: 13),
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Custom TextField Design
                          _buildTextField(
                            controller: emailController,
                            hintText: "Email Address",
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email tidak boleh kosong";
                              } else if (!value.contains('@')) {
                                return "Format email tidak valid";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: passwordController,
                            hintText: "Password",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password tidak boleh kosong";
                              } else if (value.length < 6) {
                                return "Password terlalu singkat";
                              }
                              return null;
                            },
                          ),
                          
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text(
                                "Remember Me",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.greyColorOr,
                                ),
                              ),
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.blueForgot,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 32),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: AppColor.blueButtons,
                              elevation: 4,
                              shadowColor: AppColor.blueButtons.withOpacity(0.4),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(child: Divider(color: AppColor.greyColorDivider)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text("Or continue with", style: TextStyle(color: AppColor.greyColorOr, fontSize: 12)),
                              ),
                              Expanded(child: Divider(color: AppColor.greyColorDivider)),
                            ],
                          ),
                          const SizedBox(height: 24),
                          
                          Row(
                            children: [
                              Expanded(
                                child: _buildSocialButton(
                                  image: AppImage.google,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildSocialButton(
                                  image: AppImage.fb,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Don’t have an account? ",
                          style: const TextStyle(color: Colors.black87, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.push(const RegisterScreenDay20()),
                              style: TextStyle(
                                color: AppColor.blueForgot,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    required String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColor.greyColorOr.withOpacity(0.7), fontSize: 14),
        prefixIcon: Icon(icon, color: AppColor.greyColorOr, size: 20),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColor.gradientColor2, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String image, required VoidCallback onPressed}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      onPressed: onPressed,
      child: Image.asset(image, height: 24),
    );
  }
}
