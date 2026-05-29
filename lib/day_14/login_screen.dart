import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ppkd_b6/constant/app_color.dart';
import 'package:ppkd_b6/constant/app_image.dart';
import 'package:ppkd_b6/day_15/main_screen_drawer.dart';
import 'package:ppkd_b6/day_19/database/preference_handler.dart';
import 'package:ppkd_b6/extension/navigator.dart';
import 'package:ppkd_b6/utils/button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreenDay14 extends StatefulWidget {
  const LoginScreenDay14({super.key});

  @override
  State<LoginScreenDay14> createState() => _LoginScreenDay14State();
}

class _LoginScreenDay14State extends State<LoginScreenDay14> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImage.bg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Image.asset(AppImage.logo, width: 128)],
                    ),
                    SizedBox(height: 24),

                    Container(
                      padding: EdgeInsets.all(24),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientText(
                            'Get Started now',
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                            colors: [
                              AppColor.gradientColor1,
                              AppColor.gradientColor2,
                              AppColor.gradientColor3,
                            ],
                          ),

                          Text(
                            "Create an account or log in to explore our app",

                            style: TextStyle(color: AppColor.greyColorOr),
                          ),
                          SizedBox(height: 24),
                          ButtonWithIcon(
                            image: AppImage.google,
                            text: "Sign in with Google",
                          ),
                          ButtonWithIcon(
                            image: AppImage.fb,
                            text: "Sign in with Facebook",
                          ),
                          SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColor.greyColorDivider,
                                ),
                              ),
                              SizedBox(width: 24),

                              Text(
                                "Or",
                                style: TextStyle(color: AppColor.greyColorOr),
                              ),
                              SizedBox(width: 24),

                              Expanded(
                                child: Divider(
                                  color: AppColor.greyColorDivider,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),

                          textTitleForm("Email"),
                          SizedBox(height: 12),

                          textFormConst(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email tidak boleh kosong";
                              } else if (!value.contains('@')) {
                                return "Format email tidak valid";
                              }
                              return null;
                            },
                            hintText: "Masukkan Email",
                          ),
                          SizedBox(height: 24),

                          textTitleForm("Password"),
                          SizedBox(height: 12),

                          textFormConst(
                            controller: passwordController,
                            hintText: "Masukkan Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password tidak boleh kosong";
                              } else if (value.length < 6) {
                                return "Password terlalu singkat";
                              }
                              return null;
                            },
                          ),
                          // Text(
                          //   emailController.text,
                          //   style: TextStyle(fontSize: 50),
                          // ),
                          SizedBox(height: 24),

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
                                  fontSize: 12,
                                  color: AppColor.blueForgot,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),

                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: AppColor.blueButtons,
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print("Sudah memenuhi syarat");
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Berhasil"),
                                        content: Text("Anda berhasil login"),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              await PreferenceHandler.setLogin(
                                                true,
                                              );
                                              context.push(
                                                MainScreenDrawerDay15(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text,
                                                ),
                                              );
                                              // context.push(MainScreen2Day15());
                                            },
                                            child: Text("Lanjut"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  print(emailController.text);
                                  Fluttertoast.showToast(
                                    msg: "Silakan periksa kembali",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(content: Text("Silakan periksa kembali")),
                                  // );
                                }
                              },
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          Text.rich(
                            TextSpan(
                              text: "Don’t have an account? ",
                              style: TextStyle(color: AppColor.greyColorOr),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                    color: AppColor.blueForgot,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField textFormConst({
    required String hintText,
    required String? Function(String?)? validator,
    required TextEditingController controller,
  }) {
    return TextFormField(
      onChanged: (value) {
        setState(() {});
      },
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: borderConst(),
        focusedBorder: borderConst(),
        border: borderConst(),
      ),
    );
  }

  OutlineInputBorder borderConst() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColor.greyColorDivider),
    );
  }

  Widget textTitleForm(String text) => Row(
    children: [
      Text(text, style: TextStyle(color: AppColor.greyColorOr, fontSize: 12)),
    ],
  );
}
